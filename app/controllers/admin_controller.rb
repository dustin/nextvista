class AdminController < ApplicationController

  include AuthenticatedSystem

  before_filter :login_from_cookie
  before_filter :login_required

  def toggle_comment_delete
    @comment=Comment.find params[:id].to_i
    @comment.deleted=!@comment.deleted
    @comment.save!
    request.format = :js
  end

  def index
    subtitle 'Administative Stuff'
  end

  def recent_comments
    subtitle 'Admin:  Recent Comments'
    @comments=Comment.find :all, :limit => 50, :order => "created_at desc"
  end

  protected

  def authorized?
    logged_in? && current_user.admin?
  end

end
