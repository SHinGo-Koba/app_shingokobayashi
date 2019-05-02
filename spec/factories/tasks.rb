FactoryBot.define do
  factory :task do
    project_id { 1 }
    user_id { 1 }
    body { "MyString" }
  end
end
