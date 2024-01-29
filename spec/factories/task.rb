FactoryBot.define do
  factory :task do
    association :project
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    status { 'pending' }
  end
end
