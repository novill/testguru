class QuestionsController < ApplicationController
  before_action :set_test, only: [:index, :create, :new]
  before_action :set_question, only: [:show, :destroy, :edit]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_for_test_not_found

  def show
    render plain: @question.body
  end

  def new
    @question = @test.questions.new
  end

  def create
    question = @test.questions.new(question_params)

    if question.save
      redirect_to test_path(@test)
    else
      @errors = question.errors.full_messages.join(',')
      render :new
    end
  end

  def edit
    @test = @question.test
    Rails.logger.info '-'*50
    Rails.logger.info @test.inspect
    Rails.logger.info @question.inspect
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to test_path(@test)
  end

private

  def rescue_for_test_not_found
    render plain: "Not found #{params}", status: :not_found
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
