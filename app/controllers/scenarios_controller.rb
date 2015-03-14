class ScenariosController < ApplicationController
  before_action :authenticate, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_scenario, only: [:show, :edit, :update, :destroy]
  before_action :require_permission, only: [:edit, :update, :destroy]

  # GET /scenarios
  # GET /scenarios.json
  def index
    @scenarios = Scenario.where(published: true)
  end

  # GET /scenarios/1
  # GET /scenarios/1.json
  def show
    @play = Play.new(scenario: @scenario)
  end

  # GET /scenarios/new
  def new
    # To Do: Handle a lot of universes.
    @universes = Universe
      .where('published = true OR user_id = ?', current_user)
      .order(:name)
    @scenario = Scenario.new
  end

  # GET /scenarios/1/edit
  def edit
  end

  # POST /scenarios
  # POST /scenarios.json
  def create
    @scenario = Scenario.new(scenario_params)
    @scenario.user = current_user

    respond_to do |format|
      if @scenario.save
        format.html { redirect_to @scenario, notice: 'Scenario was successfully created.' }
        format.json { render :show, status: :created, location: @scenario }
      else
        format.html { render :new }
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scenarios/1
  # PATCH/PUT /scenarios/1.json
  def update
    respond_to do |format|
      if @scenario.update(scenario_params)
        format.html { redirect_to @scenario, notice: 'Scenario was successfully updated.' }
        format.json { render :show, status: :ok, location: @scenario }
      else
        format.html { render :edit }
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scenarios/1
  # DELETE /scenarios/1.json
  def destroy
    @scenario.destroy
    respond_to do |format|
      format.html { redirect_to scenarios_url, notice: 'Scenario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_scenario
      @scenario = Scenario.includes(:contacts).find(params[:id])
      @owner = @scenario.user == current_user
    end

    def require_permission
      render_bad_credentials unless @owner
    end

    def scenario_params
      params.require(:scenario).permit(:name, :description, :solution, :par, :universe_id, :published)
    end
end
