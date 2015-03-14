class PlaysController < ApplicationController
  before_action :set_play, only: [:show, :visit, :book, :finish, :result]
  before_action :set_location, only: [:visit, :book]
  before_action :require_permission, except: [:index, :create]

  # GET /plays
  # GET /plays.json
  def index
    @user_plays = Play.where(user: current_user).includes({scenario: :user}, :actions)
    @plays = Scenario.where(published: true).map do |scenario|
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
    @play.active = true
    @play.user = if current_user
                   current_user
                 else
                   user = User.new_guest_user
                   login_user(user, redirect=false)
                   user
                 end

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

  # GET /plays/1/visit/1
  # Shows a booked location.
  def visit
    return render :show unless Action.exists?(play: @play, location: @location)
    @contact = @play.scenario.contacts.find_by(location: @location)
  end

  # POST /plays/1/visit
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

  # GET /plays/result
  def result
    @guesses = guesses
  end

  # POST /plays/1/finish
  # POST /plays/1/finish.json
  def finish
    @play.points = 0
    @play.active = false

    guesses.each do |guess|
      @play.points += guess.points if guess.points
    end

    respond_to do |format|
      if @play.save
        format.html {redirect_to result_play_path(@play)}
        format.json {render json: @play.points}
      else
        format.html {redirect_to play_guesses_path(@play)}
        format.json {render json: @action.errors, status: :unprocessable_entity}
      end
    end
  end


  private
  def guesses
    Guess.includes({question: :answers}, :answer, :location, :contact).where(play: @play)
  end

  def set_play
    @play = Play.find(params[:id])
  end

  def set_location
    @location = Location.find(params[:location_id])
  end

  def require_permission
    render_bad_credentials if @play.user != current_user
  end

  def play_params
    params.require(:play).permit(:scenario_id)
  end
end
