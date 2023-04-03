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
    Match.where(id: self.entries.pluck(:match_id))
  end
  
  def participate_all_games_result_hash_sorted
    
    hash = Hash.new { |h,k| h[k] = {} }
     # このuserが参加した全gameのid配列
    self.participate_all_games.pluck(:match_inning_id).each do |match_inning_id|
      game_result = MatchResult.where(match_inning_id: match_inning_id).pluck(:user_id, :point).to_h
      hash[match_inning_id] = game_result.sort_by{ |_, v| -v }.to_h  # 例 {272 => {9=>75, 6=>66, 7=>58}} ０番目に1位
    end

    return hash
  end
  
  def first_place_games
    
    array = []
    participate_all_games_result_hash_sorted = self.participate_all_games_result_hash_sorted
    participate_all_games_result_hash_sorted.each{|inning, result|
      if result.keys[0] == self.id
        array.push(MatchInning.find(inning.to_i))
      end
    }
    return array
  end
  
  # userが参加したmatchの結果（各matchはランク済）
  # {1=>{49=>{11=>101, 2=>60, 1=>49, 8=>0}, 50=>{1=>0, 2=>0, 3=>0, 7=>0}, 54=>{3=>56, 2=>33, 1=>12}, 55=>{1=>0, 2=>0, 3=>0}}} 
  def matches_ranked_result_participated
    hash = Hash.new { |h,k| h[k] = {} }
    matches_participated_in = self.participate_all_matches
    matches_participated_in.each do |match|
      hash[self.id][match.id] = match.rank_in_match[match.id]
    end
    
    return hash
    # 
  end
  
  def first_place_matches
    
    first_place_count = 0
    array = []
    
    matches_ranked_result_user_participated = self.matches_ranked_result_participated
    matches_ranked_result_user_participated[self.id].each do |match_result|
        if match_result[1].keys[0] == self.id
          array << Match.find_by(id: match_result[0])
        end
    end
    
    return array
    
  end
  
  

  
  # あるマッチの中のgame
  
  # hash = {}
  # User.find(7).match_results.pluck(:id, :point).to_h
  # result = numbers.max_by { |k, v| v }[0]
  # h.sort_by { |_, v| -v }.to_h
end
