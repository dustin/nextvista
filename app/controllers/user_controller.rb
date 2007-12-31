class UserController < ApplicationController

  def show
    @user=User.find_by_login params[:login]
    subtitle "User Archive: #{@user.display_name}"
    @videos=Video.find :all, :conditions => { :submitter_id => @user.id}
  end

end
