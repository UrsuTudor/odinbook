FactoryBot.define do
  factory :post do
    title { "Sample Post" }
    body { "This is a sample post body." }
    association :author, factory: :user
  end
end
