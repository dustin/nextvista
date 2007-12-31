class VideoController < ApplicationController

  def index
    # This is currently the index, so it's not specifically titled.
    @videos=Video.find :all, :order => "submit_date desc"
  end

  def show
    @video=Video.find_by_url_slug params[:slug], :include => [:submitter, :language]
    subtitle "Video: #{@video.title}"
  end

end
