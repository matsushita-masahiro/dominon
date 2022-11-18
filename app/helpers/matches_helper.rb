module MatchesHelper
    
    
    def match_total_by_user(match_id, user_id)
        if m = Match.find_by(id: match_id)
            match_innings_ids = m.match_innings.order(:inning_number).pluck(:id)
            logger.debug("==============match_innings_ids = #{match_innings_ids}")
            total = MatchResult.where(user_id: user_id, match_inning_id: match_innings_ids).pluck(:point).sum
            logger.debug("==============match_innings_ids = #{total}")
        else
            total = 9999
            logger.debug("=========== match not found")
        end
        
        return total
    end 
    
    
end
