class EntriesController < ApplicationController
    
    before_action :get_match, only: [:create, :new]
    
    def new
       @users = User.all.order(:skill_level)
       @entry = @match.entries.build
    end
    
    def create
        puts params[:entry][:user_ids]
        params[:entry][:user_ids].each do |user_id|
            @match.entries.create(user_id: user_id)
        end
        # @entries = @match.entries.create(entries_params)
        redirect_to match_enter_point_path(@match)
    end
    
    private
      def get_match
          @match = Match.find(params[:match_id])
      end
      
      def entries_params
          params.require(:entry).permit(user_ids: [])
      end
      
end
