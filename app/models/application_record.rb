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
  
  def get_point_by_player_number(n)
      if n == 2
          get_point = [0,100,30]
      elsif n == 3
          get_point = [0,100,40,0]
      elsif n >= 4 && n <= 6
          get_point = [0,100,50,20,0,0,0]
      else
          get_point = [0,0,0,0,0,0,0]
      end
      
      return get_point
  end

end
