class MatchInning < ApplicationRecord
    belongs_to :match
    has_many :match_results, dependent: :destroy
    accepts_nested_attributes_for :match_results
    
    # 配列保存
    serialize :version_used, JSON
end
