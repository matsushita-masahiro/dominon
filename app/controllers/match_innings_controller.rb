class MatchInningsController < ApplicationController

  # before_action :match_inning_params, only: [:create]
  
  def create
    # logger.debug("=============== match inninng create match_params = #{match_params[:match_id]}")
    logger.debug("=============== match inninng create match_inning_params = #{params[:match_inning]}")
    # {"0"=>{"user_id"=>"1", "point"=>"1"}, "1"=>{"user_id"=>"2", "point"=>"2"}, "2"=>{"user_id"=>"3", "point"=>"3"}}
    @match = Match.find(params[:match_id])
    version_used = params[:match_inning][:extended_version_ids].reject(&:empty?)
    match_results = params[:match_inning][:match_results_attributes]
    last_match_inning = MatchInning.where(match_id: @match.id).order(:inning_number).present? ? 
                        MatchInning.where(match_id: @match.id).order(:inning_number).last.inning_number : 0
    new_inning_number = last_match_inning + 1
    @match_inning = MatchInning.create(match_id: @match.id, inning_number: new_inning_number, version_used: version_used)
    match_results.each do |key, value|
      MatchResult.create(match_inning_id: @match_inning.id, user_id: value[:user_id], point: value[:point])
    end
    redirect_to match_enter_point_path(@match)
  end

  def edit
  end
  
  private
    def match_inning_params
      params.require(:match_inning).permit(match_results_attributes: {})
    end
    
    def match_params 
      params.permit(:match_id)
    end
  
end
