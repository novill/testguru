class  BadgesController < ApplicationController

  def index
    @badges = Badge.all
  end


  def index_by_user
    @user_badges = current_user.user_badges
  end
end
