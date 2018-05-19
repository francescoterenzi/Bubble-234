class UsersController < ApplicationController
  def myprofile
    @user = current_user
    if @user == nil
      redirect_to root_path, flash: {:alert => 'No user found'}
    end
  end

  def profile
    @user = User.find(params[:id])
    if @user == nil
      redirect_to root_path, flash: {:alert => 'No user found'}
    end
  end

  def favorites
    authenticate_user!
    @cocktails = current_user.favorites
  end

  def results
    @username = params[:usr]
    @users = User.where("username like ?", "%#{@username}%").order(:username)
    if @users.size == 0
      flash[:warning] = 'No users found!'
      redirect_to root_path
    end
  end
end