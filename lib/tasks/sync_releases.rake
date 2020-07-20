# frozen_string_literal: true

namespace :releases do
  desc 'Sync the latest releases from all artists'
  task sync: :environment do
    puts 'Starting fetch and send new releases'
    FetchAndSendNewReleasesJob.perform_later
    puts 'Job enqueued'
  end
end
