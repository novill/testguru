class TestsController < ApplicationController
  before_action :set_test, only: :start

  def index
    @tests = Test.all # .includes(:questions).to_a
  end

  def start
    current_user.tests.push(@test) # find_or_create
    redirect_to current_user.test_passage(@test)
  end

  private

    def set_test
      @test = Test.find(params[:id])
    end
end
