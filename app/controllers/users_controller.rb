class UsersController < ApplicationController
  
  def index
    # rating順にsort
    @users_hash = {}
    @users = []
    User.all.each do |user|
      @users_hash[user.id] = user.rating
    end
    
    @users_hash.sort_by { |_, v| v }.reverse.to_h
    
    @users = User.where(id: @users_hash.keys)
    # logger.debug("~~~~~~~~ @users = #{@users}")
    
  end

  def show
    @user = User.find_by(id: params[:id])
    # if @user
    # else
    # end
  end
  
  def mypage
    @user = current_user
  end
  
end
