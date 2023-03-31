class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  has_many :entries, dependent: :destroy
  has_one :admin
  has_many :match_results
  
  # あるuserが参加した全game
  # def participate_all_games
  #   self.match_innings
  # end
  
  # def played_matches
  #   self.entries
  # end
  
end
