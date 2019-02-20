class QuestionsController < ApplicationController

  before_action :set_test

  def index
    render plain: @test.questions.map(&:body).join("\n")
  end

  def show
    set_question
    render plain: @question.body
  end

private
  def set_question
    @question = @test.questions.find(params[:id])
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

end