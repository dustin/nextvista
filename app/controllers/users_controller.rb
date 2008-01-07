class UsersController < ApplicationController

  # render new.rhtml
  def new
  end

  def show
    @user=User.find_by_login params[:login]
    subtitle "User Archive: #{@user.display_name}"
    @videos=Video.find :all, :conditions => { :submitter_id => @user.id}
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save!
    self.current_user = @user
    redirect_back_or_default('/')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

end
