class GuessesController < ApplicationController
  before_action :set_play
  before_action :require_permission

  # GET /plays/:play_id/guesss
  # GET /plays/:play_id/guesss.json
  def index

  end

  # GET /plays/:play_id/guesss/new
  def new
    question = Question.find(params[:question])

    @guess = Guess.new({
      question: question,
      play: @play,
    })
  end

  # POST /plays/:play_id/guesss
  # POST /plays/:play_id/guesss.json
  def create
    @guess = Guess.new(guess_params)
    @guess.play = @play

    respond_to do |format|
      if @guess.save
        format.html {redirect_to play_guesses_path(@play)}
        format.json {render json: "ok"}
      else
        format.html {redirect_to play_guesses_path(@play), flash: {error: @guess.errors.full_messages}}
        format.json {render json: @guess.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  def set_play
    @play = Play.find(params[:play_id])
  end

  def require_permission
    render_bad_credentials root unless @play.user == current_user
  end

  def guess_params
    params.require(:guess).permit(:question_id, :answer_id, :contact_id, :location_id)
  end
end
