FactoryBot.define do
  factory :follow_request do
    association :sender, factory: :user
    association :recipient, factory: :user
    status { "pending" }
  end
end
