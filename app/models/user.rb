class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  has_many :entries, dependent: :destroy
  has_one :admin
  has_many :match_results
  
  # あるuserが参加した全game
  def participate_all_games
    self.match_results
  end
  
  def participate_all_matches
    self.entries
  end
  
  def participate_all_games_result_hash_sorted
    
    hash = Hash.new { |h,k| h[k] = {} }
     # このuserが参加した全gameのid配列
    self.participate_all_games.pluck(:match_inning_id).each do |match_inning_id|
      hash = {match_inning_id => MatchResult.where(match_inning_id: match_inning_id).pluck(:user_id, :point).to_h}
      hash[match_inning_id] = hash[match_inning_id].sort_by { |_, v| -v }.to_h  # 例 {272 => {9=>75, 6=>66, 7=>58}} ０番目に1位
    end
    
    
    return hash
  end
  
  # hash = {}
  # User.find(7).match_results.pluck(:id, :point).to_h
  # result = numbers.max_by { |k, v| v }[0]
  # h.sort_by { |_, v| -v }.to_h
end
