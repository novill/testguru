class TestPassagesController < ApplicationController
  before_action :set_test_passage, only: [:show, :update, :result, :send_gist]

  def show
  end

  def result
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
    gist_response = GistQuestionService.new(question).call

#    gist_url = gist_response.html_safe не работает
    gist_url = "https://gist.github.com/#{gist_response.id}"

    gist = Gist.create(question: @test_passage.current_question,
                       user: current_user,
                       url: gist_url)

    link = "<a href=\"#{gist_url} target=\"_blank\">Gist</a>".html_safe
    redirect_to test_passage_path(@test_passage), notice: "Your #{link} sent"
  end

  private

    def set_test_passage
      @test_passage = TestPassage.find(params[:id])
    end
end
