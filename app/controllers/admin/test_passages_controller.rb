class Admin::TestPassagesController < Admin::BaseController
  def index
    @test_passages = TestPassage.all
  end
end
