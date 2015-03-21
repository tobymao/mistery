class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_scenario
  before_action :require_permission

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all.order(:id)
    @new_answer = params[:new_answer].to_i
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    puts question_params
    @question = Question.new(question_params)
    @question.scenario = @scenario

    respond_to do |format|
      if @question.save
        format.html { redirect_to [@scenario, @question], notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html {redirect_to [@scenario, @question], notice: 'Question was successfully updated.'}
        format.json {render :show, status: :ok, location: @question}
      else
        format.html {redirect_to [@scenario, @question]}
        format.json {render json: @question.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to scenario_questions_url(@scenario), notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def set_scenario
      @scenario = Scenario.find(params[:scenario_id])
    end

    def require_permission
      render_bad_credentials root unless @scenario.user == current_user
    end

    def question_params
      params.require(:question).permit(:text, :points, answers_attributes:[:id, :location_id, :suspect_id, :text, :correct])
    end
end
