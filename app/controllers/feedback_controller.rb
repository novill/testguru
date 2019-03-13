class FeedbackController < ApplicationController
  def new
  end

  def send_email
    message = params[:message]
    render :new, notice: 'Message is empty' if message.blank?
    begin
      FeedbackMailer.send_email(message, current_user.email).deliver_now
      redirect_to tests_path, notice: "Your feedback was sent. Administrator will answer to #{current_user.email}"
    rescue StandardError => e
      render :new, notice: e.message
    end
  end
end
