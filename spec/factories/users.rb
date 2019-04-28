FactoryBot.define do
  factory :user do
    user_name { "test" }
    password { "#{user_name}1234" }
  end
end
