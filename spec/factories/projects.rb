FactoryBot.define do
  factory :project do
    title { "Title" }
    summary { "This is summary of #{title}" }
    association :organizer
  end
end
