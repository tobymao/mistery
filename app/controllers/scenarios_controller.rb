class ScenariosController < ApplicationController
  before_action :authenticate, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_scenario, only: [:show, :edit, :update, :destroy]
  before_action :require_permission, only: [:edit, :update, :destroy]

  # GET /scenarios
  # GET /scenarios.json
  def index
    @start = params[:start] || 0
    # Maybe cache this?
    @count = (Scenario.published.count / 10.0).ceil
    @scenarios = Scenario.published.limit(10).offset(@start)
  end

  # GET /scenarios/1
  # GET /scenarios/1.json
  def show
    if !@scenario.published && !@owner
      render_bad_credentials
    end

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
    @selected_location = @scenario.locations.find {|location| location.id.to_s == params[:location]}
  end

  # POST /scenarios
  # POST /scenarios.json
  def create
    @scenario = Scenario.new(scenario_params)
    @scenario.user = current_user

    respond_to do |format|
      if @scenario.save
        format.html { redirect_to edit_scenario_path(@scenario), notice: 'Scenario was successfully created.' }
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
        if params[:scenario][:questions_attributes]
          format.html {redirect_to scenario_questions_path(@scenario, new_answer: params[:new_answer])}
          format.json {render :show, status: :ok}
        else
          format.html {redirect_to edit_scenario_path(@scenario, location: params[:location])}
          format.json {render :show, status: :ok, location: @scenario}
        end
      else
        format.html {redirect_to :back, flash: {error: "Error saving your scenario. #{@scenario.errors.full_messages}"}}
        format.json {render json: @scenario.errors, status: :unprocessable_entity}
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
      @scenario = Scenario.includes(contacts: :location).find(params[:id])
      @owner = @scenario.user == current_user
    end

    def require_permission
      render_bad_credentials unless @owner
    end

    def scenario_params
      # Because changing the question type submits the form. Bad attributes can be sent.
      # This sanitizes them. Ideally, the client would handle this, but I don't have a good way now.
      if questions = params[:scenario][:questions_attributes]
        questions.each do |q_index, question|
          category = question[:category].to_i

          if answers = question[:answers_attributes]
            answers.each do |a_index, answer|
              answer.each do |k, v|
                if v.blank?
                  answers.delete(a_index)
                  next
                end
              end

              if (category == Question::CATEGORY_SUSPECT && answer[:location_id].present?) ||
                  (category == Question::CATEGORY_LOCATION && answer[:suspect_id].present?)
                answers.delete(a_index)
              end
            end
          end
        end
      end

      params.require(:scenario).permit(
        :name,
        :description,
        :solution,
        :par,
        :universe_id,
        :published,
        contacts_attributes: [:id, :text, :location_id],
        suspects_attributes: [:id, :name, :_destroy],
        questions_attributes: [:id, :category, :text, :points, :_destroy, answers_attributes:[
          :id, :location_id, :suspect_id, :text, :correct, :_destroy
        ]],
      )
    end
end
