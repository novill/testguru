class TestsController < ApplicationController

  def index
    page = [@errors, Test.all.map(&:to_s)].compact
    render plain: page.join("\n")
  end

end