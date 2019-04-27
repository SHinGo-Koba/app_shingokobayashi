require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST users_path" do
    it "works through create action" do
      expect(User.count).to eq(0)
        post users_path,
          params: { user: {
            user_name: "test1",
            password: "test11234"
          }}
      expect(User.count).to eq(1)
      follow_redirect!
      expect(response.body).to include()
    end
  end
end
