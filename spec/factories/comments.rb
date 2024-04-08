FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph }
    feature
  end
end