require 'faker'

FactoryGirl.define do
  factory :task do
    association :user
    title { Faker::Lorem.word }
    due_date { Faker::Date.forward(23) }
    priority { Faker::Number.number(3) }
  end
end
