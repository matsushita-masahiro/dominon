class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  has_many :entries, dependent: :destroy
  has_one :admin
  
  
  # def played_matches
  #   self.entries
  # end
  
end
