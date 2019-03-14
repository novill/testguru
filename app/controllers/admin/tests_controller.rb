class Admin::TestsController < Admin::BaseController
  before_action :set_tests, only: [:index, :update_inline]
  before_action :set_test, only: [:show, :edit, :update, :destroy, :update_inline]

  def index
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
      redirect_to admin_test_path(@test), notice: t('.success')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @test.update(permitted_params)
      redirect_to [:admin, @test]
    else
      render :new
    end
  end

  def update_inline
    if @test.update(permitted_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

    def permitted_params
      params.require(:test).permit(:title, :timer, :level, :category_id, :user_id)
    end

    def set_test
      @test = Test.find(params[:id])
    end

    def set_tests
      @tests = Test.all
    end
end
