class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def rank_in_method(hash, id)
    ranking = {}
      [1,2,3,4,5,6].each do |rank|
        ranking[rank] = []
      end
      rank = 1
      vp = hash[id].values[0]
      hash[id].each_with_index do |ranked_hash, i|
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
