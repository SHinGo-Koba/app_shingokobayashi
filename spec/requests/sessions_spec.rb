require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST login_path" do
    let!(:user1){ create(:user, user_name: "user1") }

    it "login with registered user" do
      post login_path,
        params: { session: {
          user_name: user1.user_name,
          password: user1.password,
        }}
      follow_redirect!
      expect(response.body).to include("Login successfully!!")
    end

    it "logout successfully" do
      post login_path,
        params: { session: {
          user_name: user1.user_name,
          password: user1.password,
        }}
      follow_redirect!
      expect(response.body).to include("Login successfully!!")

      delete logout_path
      follow_redirect!
      expect(response.body).to include("Logout!!")
    end

    it "fail to login because of invalid password" do
      post login_path,
        params: { session: {
          user_name: user1.user_name,
          password: "hogehoge",
        }}
      expect(response.body).to include("Invalid name/password combination")
      
      post login_path,
        params: { session: {
          user_name: "hogehoge",
          password: user1.password,
        }}
      expect(response.body).to include("Invalid name/password combination")
    end
    
    it "fail to login because of already login" do
      post login_path,
        params: { session: {
          user_name: user1.user_name,
          password: user1.password,
        }}
      follow_redirect!
      expect(response.body).to include("Login successfully!!")

      post login_path,
        params: { session: {
          user_name: user1.user_name,
          password: user1.password,
        }}
      follow_redirect!
      expect(response.body).to include("Please logout first")
    end
    
    it "fail to logout because no login before" do
      delete logout_path
      follow_redirect!
      expect(response.body).to include("Already logout")
    end
    
  end
end
