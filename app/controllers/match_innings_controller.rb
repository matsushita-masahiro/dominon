class MatchInningsController < ApplicationController

  before_action :match_inning_params, only: [:create]
  before_action :match_results_params, only: [:update]
  
  
  def create
    save_flag = true
    @match = Match.find(params[:match_id])
    @entries = @match.entries 
    @match_innings = MatchInning.where(match_id: @match.id).order(:inning_number)
    @extended_versions = ExtendedVersion.all
    # logger.debug("=============== match inninng create match_params = #{match_params[:match_id]}")
    @match_results = params[:match_inning][:match_results_attributes]
    logger.debug("================= @entries.count = #{@entries.count}")
    # logger.debug("================= @match_results.size = #{@match_results.size}")
    # if @entries.count != @match_results.count
    #   save_flag = false
    # end
    @match_results.each do |key, value|
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
    
    logger.debug("============== @match_results = #{@match_results["0"][:point]}")
    
    if save_flag
      @match_results.each do |key, value|
        MatchResult.create(match_inning_id: @match_inning.id, user_id: value[:user_id], point: value[:point])
      end
      logger.debug("こんどは通った") 
      redirect_to match_enter_point_path(@match)
    else
      # 入力エラー時のnew インスタンス作成
      unless @match.match_end
        @match_inning = MatchInning.new(match_id: @match.id)
        @match_result = @match_inning.match_results.build
      end     
      flash.now[:error] = "使用拡張版か点数が未入力です"
      logger.debug("また通った")
      render '/matches/enter_point'
    end
    
  end

  def edit
    @match = Match.find(params[:match_id])
    @match_inning = MatchInning.find(params[:id])
    @match_results = @match_inning.match_results.order(:user_id)
    @used_extended_versions_names = ExtendedVersion.where(id: @match_inning.version_used).pluck(:name)
    @extended_versions = ExtendedVersion.all
  end
  
  def update
    @match = Match.find(params[:match_id])
    @match_inning = MatchInning.find(params[:id])
    @match_results = @match_inning.match_results.order(:user_id)  
    logger.debug("~~~~~~~~~~~~~~~~~~~ params = #{match_results_params}")
    @match_inning.update(version_used: match_results_params[:version_used]) if match_results_params[:version_used].present?
    match_results_params[:point].each do |user_id, point|
      MatchResult.find_by(match_inning_id: @match_inning.id, user_id: user_id).update(point: point) if point.present?
    end
    redirect_to match_enter_point_path(@match)
  end
  
  def index
    @match = Match.find(params[:match_id])
    redirect_to match_enter_point_path(@match)
  end
  
  private
    def match_inning_params
      params.require(:match_inning).permit(match_results_attributes: {})
    end
    
    def match_params 
      params.permit(:match_id)
    end
    
    def match_results_params
      params.permit(point: {}, version_used: [])
    end
    

  
end
