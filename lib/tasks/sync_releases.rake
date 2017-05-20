namespace :releases do
  desc "Sync the latest releases from all artists"
  task sync: :environment do
    puts "Starting releases sync"
    FetchNewReleasesJob.new.perform
    puts "Finished!"
  end
end
