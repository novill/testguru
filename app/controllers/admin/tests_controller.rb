class Admin::TestsController < Admin::BaseController
  before_action :set_test, only: [:show, :edit, :update, :start, :destroy]

  def index
    @tests = Test.all # .includes(:questions).to_a
  end

  def show
    @questions = @test.questions
  end

  def new
    @test = Test.new(user_id: current_user.id)
  end

  def create
    @test = Test.new(permitted_params)
    if @test.save
      redirect_to admin_test_path(@test)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @test.update(permitted_params)
      admin_test_path(@test)
    else
      render :new
    end
  end

  def start
    current_user.tests.push(@test) # find_or_create
    redirect_to current_user.test_passage(@test)
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

    def permitted_params
      params.require(:test).permit(:title, :level, :category_id, :user_id)
    end

    def set_test
      @test = Test.find(params[:id])
    end
end
