class HeywatchController < ApplicationController

  before_filter :find_item

  def encoded
    @item.remote_id = params[:encoded_video_id]
    @item.state = IncomingVideo::STATE_ENCODED
    @item.save
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
    iv.save!
    render :nothing => true
  end

  protected

  def find_item
    @item = IncomingVideo.find params[:nvid]
  end
end
