class UsersController < ApplicationController

  def show
    begin
      @user = User.find(params[:id])
      @activities = (@user.reviews + @user.likes + @user.favorites).sort_by(&:created_at)
      @avg = @user.media
    rescue ActiveRecord::RecordNotFound => e
      redirect_to root_path, flash: {:alert => 'No user found'}
    end
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