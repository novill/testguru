# Preview all emails at http://localhost:3000/rails/mailers/feedback_mailer
class FeedbackMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/feedback_mailer/send_email
  def send_email
    FeedbackMailer.send_email
  end

end
