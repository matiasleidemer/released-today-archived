# frozen_string_literal: true

ActionMailer::Base.delivery_method = :test
Rails.application.config.active_job.queue_adapter = :test
