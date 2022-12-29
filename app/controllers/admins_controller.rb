class AdminsController < ApplicationController
  
  # before_action :admin?
  
  def top
    @matches = Match.all.order(created_at: :desc)
  end
  
end
