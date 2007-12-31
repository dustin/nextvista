class CommentController < ApplicationController

  include AuthenticatedSystem

  before_filter :login_from_cookie
  before_filter :login_required

  def create
    @comment=Comment.new params[:comment]
    if request.post?
      @comment.user = current_user
      @comment.created_at = Time.now
      @comment.ip_address = request.remote_addr
      @comment.save!
      redirect_to :controller => "video", :action => "show", :slug => @comment.video.url_slug
    end
  end

end
