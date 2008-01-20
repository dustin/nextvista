class IncomingVideoController < ApplicationController

  before_filter :login_required

  def new
    @iv = IncomingVideo.new params[:incoming_video]
    if request.post?
      # This should transactionally save the record and the file.
      IncomingVideo.transaction do
        @iv.submitter = current_user
        @iv.size = params[:video_file].length
        @iv.save

        @filename = "#{UPLOAD_DIR}/#{@iv.id}.bin"
        f = File.new(@filename, "wb")
        begin
          f.write params[:video_file].read
          convert @iv
        ensure
          f.close
        end
      end
    end
  end

  def download_complete
    iv = IncomingVideo.find params[:nvid]
    iv.state = IncomingVideo::STATE_TRANSFERRED
    iv.save!
  end

  protected

  def convert(iv)
    HeyWatch::Discover.create(
      :url              => iv.url,
      :download         => true,
      :nvid             => iv.id,
      :title            => iv.title,
      :automatic_encode => true,
      :ping_url_after_transfer => url_for :controller => 'incoming_video', :action => 'download_complete'
      :format_id        => 31 # flash
    )
  end

end
