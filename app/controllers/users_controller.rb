class UsersController < ApplicationController
  
  def index
    # rating順にsort
    @users_hash = {}
    @users = []
    User.all.each do |user|
      @users_hash[user.id] = user.rating
    end

    # rating順にsortしたhashからuser_idを取得して@users配列にpush
    @users_hash.sort_by { |_, v| v }.reverse.to_h.each do |user_id, rating|
      @users << User.find(user_id)
    end
    
    # logger.debug("~~~~~~~~ @users = #{@user}")
    
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
