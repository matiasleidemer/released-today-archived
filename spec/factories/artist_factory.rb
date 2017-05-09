FactoryGirl.define do
  factory :artist do
    name 'Dinosaur Jr.'
    spotify_id '267VY6GX5LyU5c9M85ECZQ'
    metadata do
      {
        "images" => [{ "height" => 1000,
                       "url" => "https://i.scdn.co/image/7c9a23b053f6f0862d860179b64a24e1b27dd6b3",
                       "width" => 1000 }]
      }
    end
  end
end
