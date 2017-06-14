class ApplicationMailer < ActionMailer::Base
  default from: 'notifier@released.today',
          reply_to: 'matias@released.today'
  layout 'mailer'
end
