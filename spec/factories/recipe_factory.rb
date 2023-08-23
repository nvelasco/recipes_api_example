FactoryBot.define do
    factory :recipe do
        title { Faker::Lorem.sentence }
        description { Faker::Lorem.paragraph }
    end
end