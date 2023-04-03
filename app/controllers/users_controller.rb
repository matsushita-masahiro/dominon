class UsersController < ApplicationController
  
  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def mypage
    @user = current_user
  end
  
end
