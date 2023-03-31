class MatchInning < ApplicationRecord
    belongs_to :match
    has_many :match_results, dependent: :destroy
    accepts_nested_attributes_for :match_results
    
    # 配列保存
    serialize :version_used, JSON
    
    def used_versions_name
        ExtendedVersion.where(id: self.version_used).pluck(:omit_word)
    end
    
    
    

    
    
       
    # scope :match_inning_user_total , -> (match_id, user_id) { 
    #     where(match_inning_id: match_inning_id, user_id: user_id).pluck(:point).sum
    #   }
end
