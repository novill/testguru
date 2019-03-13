class FeedbackMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.feedback_mailer.send_email.subject
  #
  def send_email(message, reply_to)
    @message = message
    @reply_to =reply_to
    mail to: Admin.first.email,
         reply_to: @reply_to,
         subject: 'Testguru feedback'
  end
end
