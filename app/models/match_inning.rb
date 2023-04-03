class MatchInning < ApplicationRecord
    belongs_to :match
    has_many :match_results, dependent: :destroy
    accepts_nested_attributes_for :match_results
    
    # 配列保存
    serialize :version_used, JSON
    
    def used_versions_name
        ExtendedVersion.where(id: self.version_used).pluck(:omit_word)
    end
    
    def ranked_hash_in_game
      hash = Hash.new { |h,k| h[k] = {} }  # { match_inning.id => { user.id => VP }}
      results = self.match_results
      results.each do |result|
        hash[self.id][result.user_id] = result.point
    end
      hash[self.id] = hash[self.id].sort_by{ |_, v| -v }.to_h
      return hash      
    end
    # [16, 17, 18, 19, 20, 21, 22, 23, 24, 25] 
    # {28=>{1=>322, 2=>111, 6=>54, 5=>23}} 
    def game_result_sorted
      return rank_in_method(self.ranked_hash_in_game, self.id)
    end

end
