class UserController < ApplicationController

  def show
    @user=User.find_by_login params[:login]
    @videos=Video.find :all, :conditions => { :submitter_id => @user.id}
  end

end
