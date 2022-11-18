class MatchInningsController < ApplicationController

  # before_action :match_inning_params, only: [:create]
  
  def create
    save_flag = true
    @match = Match.find(params[:match_id])
    # logger.debug("=============== match inninng create match_params = #{match_params[:match_id]}")
    match_results = params[:match_inning][:match_results_attributes]
    match_results.each do |key, value|
      if !value[:point].present?
        save_flag = false
      end
    end  
    
    if params[:match_inning][:extended_version_ids].present? && save_flag
      logger.debug("=============== match inninng create match_inning_params = #{params[:match_inning]}")
      # {"0"=>{"user_id"=>"1", "point"=>"1"}, "1"=>{"user_id"=>"2", "point"=>"2"}, "2"=>{"user_id"=>"3", "point"=>"3"}}
      version_used = params[:match_inning][:extended_version_ids].reject(&:empty?)
      last_match_inning = MatchInning.where(match_id: @match.id).order(:inning_number).present? ? 
                          MatchInning.where(match_id: @match.id).order(:inning_number).last.inning_number : 0
      new_inning_number = last_match_inning + 1
      @match_inning = MatchInning.create(match_id: @match.id, inning_number: new_inning_number, version_used: version_used)
    else
      save_flag = false
    end

    if save_flag
      match_results.each do |key, value|
        MatchResult.create(match_inning_id: @match_inning.id, user_id: value[:user_id], point: value[:point])
      end
    else
      flash[:error] = "使用拡張版か点数が未入力です"
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
