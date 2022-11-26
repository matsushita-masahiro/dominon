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
            if !self.unit_price.present?
              unit_price = 1
            end
            hash.store(user_id, differ*self.unit_price)
          }
        return hash
        
    end
      
    
    
end
