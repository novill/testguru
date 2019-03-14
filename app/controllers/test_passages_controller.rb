class TestPassagesController < ApplicationController
  before_action :set_test_passage, only: [:show, :update, :result, :send_gist]

  def show
  end

  def result
    @test_passage.set_result_to_passed
  end

  def update
    @test_passage.accept!(params[:answers_ids])

    if @test_passage.complited?
      #      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def send_gist
    question = @test_passage.current_question

    gist_response = GistQuestionService.new(question).call

    #    gist_url = gist_response.html_safe не работает
    gist_url = "https://gist.github.com/#{gist_response.id}"
    gist = Gist.new(question: question,
                    user: current_user,
                    url: gist_url)

    if gist.save
      link = "<a href=\"#{gist_url}\" target=\"_blank\">Gist</a>"
      redirect_to test_passage_path(@test_passage), notice: t('.send_gist', link: link)
    else
      render plain: gist.errors.full_messages.to_s
    end
  end

  private

    def set_test_passage
      @test_passage = TestPassage.find(params[:id])
    end
end
