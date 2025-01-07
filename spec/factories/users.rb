FactoryBot.define do
  factory :user do
    name { "Sample User" }
    age { 25 }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { '123456' }
    city { "Sample city" }
  end
end
