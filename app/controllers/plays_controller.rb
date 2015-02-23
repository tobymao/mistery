class PlaysController < ApplicationController
  before_action :set_play, only: :show

  # GET /plays
  # GET /plays.json
  def index
    @user = current_user
    @active_plays = Play.where(user: @user).includes(:scenario)
    @plays = Scenario.all.map do |scenario|
      Play.new(scenario: scenario)
    end
  end

  # GET /plays/1
  # GET /plays/1.json
  def show
  end

  # POST /plays
  # POST /plays.json
  def create
    @play = Play.new(play_params)
    @play.user = current_user

    respond_to do |format|
      if @play.save
        format.html {redirect_to @play}
        format.json {render :show, status: :created, location: @play}
      else
        format.html {redirect_to plays_url}
        format.json {render json: @play.errors, status: :unprocessable_entity}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_play
      @play = Play.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def play_params
      params.require(:play).permit(:scenario_id)
    end
end
