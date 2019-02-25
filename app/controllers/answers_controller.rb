class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]
  before_action :set_question, only: %i[new create]

  # GET /answers/1
  def show
  end

  # GET /answers/new
  def new
    @answer = @question.answers.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  def create
    @answer = @question.answers.new(answer_params)

      if @answer.save
        redirect_to @answer
      else
        render :new
      end
  end

  # PATCH/PUT /answers/1
  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end

  # DELETE /answers/1
  def destroy
    @answer.destroy
    redirect_to @answer.question
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def set_question
      puts '_'*50, __method__
      @question = Question.find(params[:question_id])
      puts @question, '_'*50
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:body, :correct, :question_id)
    end
end
