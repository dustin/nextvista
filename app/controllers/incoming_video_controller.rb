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
        ensure
          f.close
        end
      end
    end
  end

end
