class QuestionsController < ApplicationController

  before_action :set_test

  def index
    render plain: @test.questions.map(&:body).join("\n")
  end

private

  def set_test
    @test = Test.find(params[:test_id])
  end

end