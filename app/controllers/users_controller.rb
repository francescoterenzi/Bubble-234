class UsersController < ApplicationController
  def myprofile
    @user = current_user
    if @user == nil
      redirect_to root_path, flash: {:alert => 'No user found'}
    end
  end

  def favorites
    authenticate_user!
    @cocktails = current_user.favorites
  end

end