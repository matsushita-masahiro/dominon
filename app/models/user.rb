class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  has_many :entries, dependent: :destroy
  has_one :admin
  has_many :match_results
  

  # あるuserが参加した全game結果
  def participate_all_games_results
    self.match_results
  end
  
  # あるuserが参加した全game(match_inning)
  def participate_all_games
    MatchInning.where(match_id: self.entries.pluck(:match_id))
  end
  
  def participate_all_matches
    Match.where(id: self.entries.pluck(:match_id))
  end
  
  def participate_all_games_result_hash_sorted
    hash = Hash.new { |h,k| h[k] = {} }
     # このuserが参加した全gameのid配列
    self.participate_all_games_results.pluck(:match_inning_id).each do |match_inning_id|
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
      hash[self.id][match.id] = match.ranked_hash_in_match[match.id]
    end
    return hash
  end

  
  def first_place_matches
    ranked_array = []
    matches_ranked_result_user_participated = self.matches_ranked_result_participated
    matches_ranked_result_user_participated[self.id].each do |match_result|
        if match_result[1].keys[0] == self.id
          ranked_array << Match.find_by(id: match_result[0])
        end
    end
    return ranked_array
  end
  
  # 1位や２位、3位だったmatch数 rank_numberが位の数字
  def rank_in_match_sorted(rank_number)
    ranked_array = []
    self.participate_all_matches.each do |match|
       # match.rank_in_match_sorted例{1=>[6], 2=>[4], 3=>[5], 4=>[1, 2, 3], 5=>[], 6=>[]}
       # match.rank_in_match_sorted例{1=>[11], 2=>[2], 3=>[1], 4=>[8], 5=>[], 6=>[]} 
        if match.rank_in_match_sorted[rank_number].include?(self.id)
          ranked_array << match
        end
    end
    return ranked_array
  end
  
  def rank_in_game_sorted(rank_number)
    ranked_array = []
    self.participate_all_games.each do |game|
       # match.rank_in_match_sorted例{1=>[6], 2=>[4], 3=>[5], 4=>[1, 2, 3], 5=>[], 6=>[]}
       # match.rank_in_match_sorted例{1=>[11], 2=>[2], 3=>[1], 4=>[8], 5=>[], 6=>[]} 
        if game.game_result_sorted[rank_number].include?(self.id)
          ranked_array << game
        end
    end
    return ranked_array
  end
  
  def rating
    rating_point_total = 0
    # (1位だったgameの回数*120＋2位だったgameの回数*60＋3位だったgameの回数*30)/全game数
    # このuserが参加した全matchインスタンス
    ranks = [1,2,3,4,5,6]
    ranks.each do |rank|
      self.rank_in_match_sorted(rank).each do |m|
        if m.entries.count == 2 
          rating_point_total = rating_point_total + get_point_by_player_number(2)[rank]
        elsif m.entries.count == 3
          rating_point_total = rating_point_total + get_point_by_player_number(3)[rank]
        elsif m.entries.count == 4
          rating_point_total = rating_point_total + get_point_by_player_number(4)[rank]
        elsif m.entries.count == 5
          rating_point_total = rating_point_total + get_point_by_player_number(5)[rank]
        elsif m.entries.count == 6
          rating_point_total = rating_point_total + get_point_by_player_number(6)[rank]
        else
          rating_point_total = rating_point_total + 0
        end
      end      
    end
    
    rate = rating_point_total/7
    
    return rate

  end
  
  # matches_ranked_result_participatedの戻り値例は下記
  # {1=>{49=>{11=>101, 2=>60, 1=>49, 8=>0}, 50=>{1=>0, 2=>0, 3=>0, 7=>0}, 54=>{3=>56, 2=>33, 1=>12}, 55=>{1=>0, 2=>0, 3=>0}}} 

  
  # あるマッチの中のgame
  
  # hash = {}
  # User.find(7).match_results.pluck(:id, :point).to_h
  # result = numbers.max_by { |k, v| v }[0]
  # h.sort_by { |_, v| -v }.to_h
end
