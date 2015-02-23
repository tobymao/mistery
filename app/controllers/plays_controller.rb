class PlaysController < ApplicationController
  before_action :set_play, only: [:show, :visit, :book]
  before_action :set_location, only: [:visit, :book]

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

  # GET /plays/1/location/1
  # Shows a booked location.
  def visit
    @contact = @play.scenario.contacts.find_by(location: @location)
  end

  # POST /plays/1/location
  # Creates an action to visit a location.
  def book
    @action = Action.new(play: @play, location: @location)

    respond_to do |format|
      if @action.save
        format.html {redirect_to visit_play_path(@play.id, @location.id)}
        format.json {render :show, status: :created, location: @action}
      else
        format.html {redirect_to plays_url}
        format.json {render json: @action.errors, status: :unprocessable_entity}
      end
    end
  end

  private
    def set_play
      @play = Play.find(params[:id])
    end

    def set_location
      @location = Location.find(params[:location_id])
    end

    def play_params
      params.require(:play).permit(:scenario_id)
    end
end
