class VideoController < ApplicationController

  def index
    @videos=Video.find :all, :order => "submit_date desc"
  end

  def show
    @video=Video.find_by_url_slug params[:slug], :include => [:submitter, :language]
  end

end
