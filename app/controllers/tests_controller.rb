class TestsController < ApplicationController
  before_action :set_test, only: :start

  def index
    @tests = Test.all # .includes(:questions).to_a
  end

  def start
     # если нет незаконченнных, создаем новый
    unless current_user.unfinished_test(@test)
      current_user.tests.push(@test)
    end

    redirect_to current_user.unfinished_test(@test)
  end

  private

    def set_test
      @test = Test.find(params[:id])
    end
end
