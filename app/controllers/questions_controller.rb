class QuestionsController < ApplicationController

  before_action :set_test

  def index
    @questions = @test.questions
    # render plain: @questions.map(&:body).join("\n")
  end

  def show
    set_question
    render plain: @question.body
  end

  def new

  end

  def create
    question = @test.questions.new(question_params)
    question.save!
    render plain: question.body
  end

  def destroy
    @test.questions.find(params[:id]).destroy

    redirect_to action: :index
  end

private

  def set_question
    @question = @test.questions.find(params[:id])
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

end