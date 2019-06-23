FactoryBot.define do
  factory :album do
    name { "Give a Glimpse of What Yer Not" }
    spotify_id { "26vGmf4YJOmS1kZK4RJ2EB" }
    image_url { "https://i.scdn.co/image/bc18f0e07ef6bab0147b1fa156d1084ef027385a" }
    number_of_tracks { 11 }
    released_at { "2016-08-05" }
  end
end
