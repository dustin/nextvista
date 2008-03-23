class HeywatchController < ApplicationController

  before_filter :find_item

  def encoded
    @item.remote_id = params[:encoded_video_id]
    @item.state = IncomingVideo::STATE_ENCODED
    @item.save
    VideoConverter.new.fetch @item, params[:filename], params[:link]
    render :nothing => true
  end

  def errored
    if params[:discover_id]
      @error_msg = "No video link found"
    else
      @error_msg = HeyWatch::ErrorCode[params[:error_code].to_i]
    end
    @item.state = IncomingVideo::STATE_ERROR
    logger.error "Error encoding video:  #{@error_msg}"
    render :nothing => true
  end

  def download_complete
    iv = IncomingVideo.find params[:nvid]
    iv.state = IncomingVideo::STATE_TRANSFERRED
    iv.remote_id = params[:video_id]
    iv.save!
    render :nothing => true
  end

  protected

  def find_item
    if params[:nvid]
      @item = IncomingVideo.find params[:nvid]
    elsif params[:video_id]
      @item = IncomingVideo.find_by_remote_id params[:video_id]
    end
  end
end
