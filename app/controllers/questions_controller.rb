class QuestionsController < ApplicationController

  before_action :set_test
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_for_test_not_found

  def index
    @questions = @test.questions

    respond_to do |format|
      format.text { render plain: @questions.map(&:body).join("\n") }
      format.html
    end
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

  def rescue_for_test_not_found
    redirect_to controller: :tests, action: :index
  end

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