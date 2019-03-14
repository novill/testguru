class Admin::TestPassagesController < ApplicationController
  def index
    @test_passages = TestPassage.all
  end
end
