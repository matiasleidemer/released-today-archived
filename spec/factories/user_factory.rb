FactoryBot.define do
  factory :user do
    name { 'John Snow' }
    email { 'john@snow.com' }
    provider { 'spotify' }
    uid { '12345' }
    admin { false }
    token { '5b65f1' }

    trait :admin do
      admin { true }
    end
  end
end
