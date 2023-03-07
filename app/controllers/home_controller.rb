class HomeController < ApplicationController
  def top
    @user = User.new
  end
end
