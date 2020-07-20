# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'Released Today<notifier@released.today>',
          reply_to: 'matias@released.today'
  layout 'mailer'
end
