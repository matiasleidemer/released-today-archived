# frozen_string_literal: true

FactoryBot.define do
  factory :user_params, class: Hash do
    skip_create

    name { 'John Snow' }
    email { 'john@snow.com' }
    provider { 'spotify' }
    uid { '456' }

    initialize_with do
      {
        name: name,
        email: email,
        provider: provider,
        uid: uid
      }
    end
  end
end
