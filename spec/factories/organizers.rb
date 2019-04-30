FactoryBot.define do
  factory :organizer do
    association :user
    organizer_name { user.user_name }
  end
end
