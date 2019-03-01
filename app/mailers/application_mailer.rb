class ApplicationMailer < ActionMailer::Base
  default from: %{"Testguru" <testguru@example.com>}
  layout 'mailer'
end
