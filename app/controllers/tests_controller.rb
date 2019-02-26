class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :start, :destroy]
  before_action :set_user

  def index
    @tests = Test.all # .includes(:questions).to_a
  end

  def show
    @questions = @test.questions
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(permitted_params)
    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @test.update(permitted_params)
      redirect_to @test
    else
      render :new
    end
  end

  def start
    @user.tests.push(@test) # find_or_create
    redirect_to @user.test_passage(@test)
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  private

    def permitted_params
      params.require(:test).permit(:title, :level, :category_id, :user_id)
    end

    def set_test
      @test = Test.find(params[:id])
    end

    def set_user
      @user = User.first
    end
end
