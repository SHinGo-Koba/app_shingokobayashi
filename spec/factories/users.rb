FactoryBot.define do
  factory :user do
    sequence(:user_name) { |n| "test#{n}" }
    password { "#{user_name}1234" }
  end
end
