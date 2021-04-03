# frozen_string_literal: true

FactoryBot.define do
  factory :dinosaur_jr, class: 'Spotify::Artist' do
    skip_create

    name { 'Dinosaur Jr.' }
    id { '1' }

    initialize_with do
      { name: name, id: id }
    end
  end

  factory :descendents, class: 'Spotify::Artist' do
    skip_create

    name { 'Descendents' }
    id { '2' }

    initialize_with do
      { name: name, id: id }
    end
  end

  factory :hot_water_music, class: 'Spotify::Artist' do
    skip_create

    name { 'Hot Water Music' }
    id { '3' }

    initialize_with do
      { name: name, id: id }
    end
  end
end
