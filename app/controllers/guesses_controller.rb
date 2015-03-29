class GuessesController < ApplicationController
  before_action :set_play
  before_action :require_permission

  # GET /plays/:play_id/guesses
  # GET /plays/:play_id/guesses.json
  def index
    render_bad_credentials if @play.active
  end

  # POST /plays/:play_id/guesses/start
  # POST /plays/:play_id/guesses/start.json
  def start
    @play.active = false
    @play.save

    respond_to do |format|
      format.html{redirect_to play_guesses_path}
      format.json{render json: "ok"}
    end
  end

  private
  def set_play
    @play = Play.find(params[:play_id])
  end

  def require_permission
    render_bad_credentials root unless @play.user == current_user
  end
end
