class Match < ApplicationRecord
    
    
    has_many :entries, dependent: :destroy
    accepts_nested_attributes_for :entries
    
    has_many :match_innings, dependent: :destroy
    
    
end
