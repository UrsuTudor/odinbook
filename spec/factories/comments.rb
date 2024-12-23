FactoryBot.define do
  factory :comment do
    body { "This is a sample comment." }
    association :author, factory: :user
    association :post
  end
end
