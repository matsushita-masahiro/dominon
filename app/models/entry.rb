class Entry < ApplicationRecord
    
    MAX_ENTRIES_COUNT = 6

    belongs_to :match
    belongs_to :user
    
    validate :entries_count_must_be_within_limit
  
    private
  
      def entries_count_must_be_within_limit
        errors.add(:base, "参加者最大#{MAX_POSTS_COUNT}名です: ") if match.entries.count >= MAX_ENTRIES_COUNT
      end    
    
    
end
