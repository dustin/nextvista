class VideoController < ApplicationController

  before_filter :login_required, :only => [:new]

  def index
    # This is currently the index, so it's not specifically titled.
    @videos=Video.find :all, :order => "submit_date desc"
  end

  def show
    @video=Video.find_by_url_slug params[:slug], :include => [:submitter, :language]
    @comments=@video.comments
    subtitle "Video: #{@video.title}"
  end

  def new
    @video = Video.new params[:video]
    if request.post?
      @video.submitter = current_user
      @video.submit_date = Date.today

      variant = @video.video_variants[0]
      variant.format = VideoFormat.find_by_name "Quicktime"
      variant.size = params[:video_file].length

      logger.info "Video:  #{@video.inspect}"
      logger.info "Variants:  #{@video.video_variants.inspect}"
      @video.save!

      f = File.new("tmp/#{@video.id}.mov", "wb")
      begin
        f.write params[:video_file].read
      ensure
        f.close
      end
    else
      @video.video_variants.build
    end
  end

end
