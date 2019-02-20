class TestsController < ApplicationController

  def index
    render plain: Test.all.map(&:to_s).join("\n")
  end

end