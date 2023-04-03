class Match < ApplicationRecord
    
    
    has_many :entries, dependent: :destroy
    accepts_nested_attributes_for :entries
    
    has_many :match_innings, dependent: :destroy
    
    
    
    def match_point_total
        
          hash = Hash.new
          match_results = MatchResult.where(match_inning_id: self.match_innings.pluck(:id))
          total = match_results.pluck(:point).sum
          
          average = total/self.entries.count.to_f.round(3)
          user_point_total = Hash.new
          self.entries.each do |entry|
              user_total = match_results.where(user_id: entry.user_id).pluck(:point).sum
              user_point_total.store(entry.user_id, (user_total.to_f).round(2) - average)
              # puts average*10 - user_total*10
          end
          
          hash.store("total", total)
          hash.store("all_average", average)
          hash.store("user_point_total", user_point_total)
        return hash
    end
    
    def match_point_calc
          hash = Hash.new
          self.match_point_total["user_point_total"].each {|user_id, differ|
            if unit_price.present?
              hash.store(user_id, differ*self.unit_price.round(2))
            else
              hash.store(user_id, differ.round(2))
            end
          }
        return hash
        
    end
    
    
    def games_of_match
      self.match_innings
    end
    
 
    
    def match_total_by_user(user_id)
            match_innings_ids = self.match_innings.order(:inning_number).pluck(:id)
            total = MatchResult.where(user_id: user_id, match_inning_id: match_innings_ids).pluck(:point).sum
        return total
    end
    
    def ranked_hash_in_match
      hash = Hash.new { |h,k| h[k] = {} }  # { match.id => { user.id => total VP }}
      
      participates = self.entries
      participates.each do |user|
        hash[self.id][user.user_id] =  self.match_total_by_user(user.user_id)  #このmatchでのあるuserの合計VP
      end
      hash[self.id] = hash[self.id].sort_by{ |_, v| -v }.to_h
      return hash
    end
    
    def rank_in_match
      ranking = {}
      [1,2,3,4,5,6].each do |rank|
        ranking[rank] = []
      end
      rank = 1
      vp = self.ranked_hash_in_match[self.id].values[0]
      self.ranked_hash_in_match[self.id].each_with_index do |ranked_hash, i|
        if vp == ranked_hash[1]
          ranking[rank] << ranked_hash[0]
        else
          rank = rank + 1
          ranking[rank] << ranked_hash[0]
        end
        vp = ranked_hash[1]
      end
      return ranking
    end
    
    
    
end
