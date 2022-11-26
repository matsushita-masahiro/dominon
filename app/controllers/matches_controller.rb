class MatchesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :get_match, only: [:show, :edit]
  
  def new
    @match = Match.new
  end
  
  def create
    @match = Match.new(match_params)
    if @match.save
      redirect_to new_match_entry_path(@match)
    else
      flash[:error] = "試合登録できませんでした"
      puts "試合登録できませんでした"
      render 'new'
    end
  end

  def index
    @matches = Match.all.order(created_at: :desc)
  end
  
  def enter_point
    @match = Match.find(params[:match_id])
    @extended_versions = ExtendedVersion.all
    @entries = @match.entries
    puts "~~~~~~~ @match = #{@match.id} --- @entries count #{@entries.count}"
    @match_innings = MatchInning.where(match_id: @match.id).order(:inning_number)
    puts "@match_innings = #{@match_innings.count}"
    # @match_innings = @match.match_innings
    unless @match.match_end
      @match_inning = MatchInning.new(match_id: @match.id)
      @match_result = @match_inning.match_results.build
    end
    # @match_result = @MatchResult.new(match_inning_id: @match_inning)
  end
  
  def input_point 
    
  end
  
  def match_end
    @match = Match.find(params[:match_id])
    @match.update(match_end: true)
    redirect_to matches_path
  end

  def edit
  end
  
  def update
  end

  def show
  end
  
  def select_member
    @match = Match.find(params[:match_id])
    @users = User.all.order(:skill_level)
  end
  
  private
    def get_match
      @match = Match.find(params[:id])
    end
    
    def match_params
      params.require(:match).permit(:name, :place, :start_time, :end_time, :held_date)
    end
    
    def input_point_params 
      params.require(:match_inning).permit(match_results_attributes: [:point])
    end
    
end
