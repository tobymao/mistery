class PlaysController < ApplicationController
  before_action :set_play, except: [:index, :create]
  before_action :set_location, only: [:visit, :book]
  before_action :require_permission, except: [:index, :create]

  # GET /plays
  # GET /plays.json
  def index
    @user_plays = Play.where(user: current_user).includes({scenario: :user}, :actions)
    @plays = Scenario.published.map do |scenario|
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

  # PATCH/PUT /plays/1
  # PATCH/PUT /plays/1.json
  def update
    respond_to do |format|
      if @play.points || @play.update(play_params)
        if !@play.points
          @play.points = 0
          @play.points -= (@play.actions.size - @play.scenario.par) * Play::LOCATION_PENTALTY

          @play.guesses.each do |guess|
            @play.points += guess.points if guess.points
          end

          @play.save
        end

        format.html {redirect_to result_play_path @play}
        format.json {render :show, status: :ok}
      else
        format.html {redirect_to :back, flash: {error: "Error saving your guesses. #{@play.errors.full_messages}"}}
        format.json {render json: @play.errors, status: :unprocessable_entity}
      end
    end
  end

  # GET /plays/1/visit/1
  # Shows a booked location.
  def visit
    return render :show if !@play.points && !Action.exists?(play: @play, location: @location)
    @contact = @play.scenario.contacts.find_by(location: @location)
  end

  # POST /plays/1/visit
  # Creates an action to visit a location.
  def book
    return render :show if !@play.active && !@play.points

    @action = Action.new(play: @play, location: @location) if @play.active

    respond_to do |format|
      if !@play.active || @action.save
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
  end

  private
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
    params.require(:play).permit(:scenario_id, guesses_attributes: [:id, :question_id, :answer_id, :suspect_id, :location_id])
  end
end
