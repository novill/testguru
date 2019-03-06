class  GistQuestionService
  def initialize(question)
    @client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    @question = question
    @test = question.test
  end

  def call
    @client.create_gist(gist_params)
  end

  private
    def gist_params
      { public: true,
        description: I18n.t('service.gist_question_service.description', title: @test.title),
        files: {
          'test-quru-question.txt' => {
              content: gist_content
          }
        }
      }
    end

    def gist_content
      [ "Send time #{Time.current}",
        @question.body,
        *@question.answers.pluck(:body)
      ].join("\n")
    end
end
