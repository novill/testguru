class QuestionsController < ApplicationController

  before_action :set_test
  before_action :set_question, only: [:show]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_for_test_not_found

  def index
    @questions = @test.questions

    respond_to do |format|
      format.text { render plain: @questions.map(&:body).join("\n") }
      format.html
    end
  end

  def show
    render plain: @question.body
  end

  def new

  end

  def create
    question = @test.questions.new(question_params)
    if question.save
      render plain: question.body
    else
      @errors = question.errors.full_messages.join(',')
      render :new
    end
  end

  def destroy
    # render json: params
    Question.find(params[:id]).destroy

    redirect_to action: :index, test_id: @test.id
  end

private

  def rescue_for_test_not_found
    render plain: 'Тест не найден', status: :not_found
  end

  def set_question
    @question = @test.questions.find(params[:id])
    #Question.find(params[:id])
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

end