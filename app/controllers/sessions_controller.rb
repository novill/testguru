class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      next_page = cookies[:request_path] || tests_path

      redirect_to next_page
      cookies.delete(:request_path)
    else
      flash.now[:alert] = 'Are you guru?'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
