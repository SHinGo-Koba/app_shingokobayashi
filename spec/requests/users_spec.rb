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
      expect(response.body).to include("User was successfully created.")
      expect(response.body).to include("test1")
    end

    it "doesn't work because of invali name or password" do # checked if validations are working through action of create
      expect{
        post users_path,
          params: { user: {
            user_name: "",
            password: "test1234"
          }}
      }.not_to change{ User.count }
      expect(response.body).to include("New User")
      expect(response.body).to include(CGI.escapeHTML("User name can't be blank"))

      expect{
        post users_path,
          params: { user: {
            user_name: "test",
            password: ""
          }}
      }.not_to change{ User.count }
      expect(response.body).to include("New User")
      expect(response.body).to include(CGI.escapeHTML("Password can't be blank"))
    end

    it "checked if factory_bot is working" do
      expect{
        test1 = create(:user)
        puts test1.user_name
        puts test1.password
      }.to change{ User.count }.by(1)

      expect{
        test2 = create(:user, user_name: "test2", password: "test4321") # checked name and password changed correctly
        puts test2.user_name
        puts test2.password
      }.to change{ User.count }.by(1)
    end

  end
end
