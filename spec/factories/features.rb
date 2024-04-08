FactoryBot.define do
  factory :feature do
    title { Faker::Lorem.sentence }
    url { Faker::Internet.url }
    place { Faker::Address.city }
    mag_type { %w[md ml ms mw me mi mb mlg].sample }
    longitude { Faker::Address.longitude }
    latitude { Faker::Address.latitude }
    magnitude { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
    time { Faker::Time.backward(days: 30) }
    external_id { Faker::Internet.uuid }
  end
end
