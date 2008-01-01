class AdminController < ApplicationController

  include AuthenticatedSystem

  before_filter :login_from_cookie
  before_filter :login_required

  def toggle_comment_delete
    @comment=Comment.find params[:id].to_i
    @comment.deleted=!@comment.deleted
    @comment.save!
  end

  protected

  def authorized?
    current_user.admin?
  end

end
