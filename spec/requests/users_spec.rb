require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST users_path" do

    it "works through create action" do
      expect(User.count).to eq(0)
      post users_path,
        params: { user: {
          user_name: "test1",
          password: "test11234",
          password_confirmation: "test11234"
        }}
      expect(User.count).to eq(1)
      follow_redirect!
      expect(response.body).to include("User was successfully created")
      expect(response.body).to include("test1")
    end

    it "doesn't work because of invali name or password" do # checked if validations are working through action of create
      expect{
        post users_path,
          params: { user: {
            user_name: "",
            password: "test1234",
            password_confirmation: "test1234"
          }}
      }.not_to change{ User.count }
      expect(response.body).to include("Failed to be created")
      expect(response.body).to include(CGI.escapeHTML("it can't be blank"))

      expect{
        post users_path,
          params: { user: {
            user_name: "test    ",
            password: "test1234",
            password_confirmation: "test1234"
          }}
      }.not_to change{ User.count }
      expect(response.body).to include("Failed to be created")
      expect(response.body).to include(CGI.escapeHTML("it only arrows letters and numbers"))

      expect{
        post users_path,
          params: { user: {
            user_name: "test",
            password: "",
            password_confirmation: ""
          }}
      }.not_to change{ User.count }
      expect(response.body).to include("Failed to be created")
      expect(response.body).to include(CGI.escapeHTML("it can't be blank"))

      expect{
        post users_path,
          params: { user: {
            user_name: "test",
            password: "test11234",
            password_confirmation: ""
          }}
      }.not_to change{ User.count }
      expect(response.body).to include("Failed to be created")
      expect(response.body).to include(CGI.escapeHTML("it doesn't match Password"))

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
  
  describe "PUT user_path" do

    it "updated successfully with different name and password" do
      post users_path,
        params: { user: {
          user_name: "test1",
          password: "test11234"
        }}
      test1 = User.find_by(user_name: "test1")
      puts test1.inspect
      
      put user_path(test1),
        params: { user: {
          user_name: "test2",
          password: "test21234"
        }}
      follow_redirect!
      expect(response.body).to include("test2")
      expect(response.body).to include("User was successfully updated")
      puts test1.reload.inspect
    end
    
    it "updated successfully with only different name" do
      post users_path,
        params: { user: {
          user_name: "test1",
          password: "test11234"
        }}
      test1 = User.find_by(user_name: "test1")
      puts test1.inspect
      
      put user_path(test1),
        params: { user: {
          user_name: "test2",
          password: ""
        }}
      follow_redirect!
      expect(response.body).to include("test2")
      expect(response.body).to include("User was successfully updated")
      puts test1.reload.inspect
    end

    it "updated successfully with only different password" do
      post users_path,
        params: { user: {
          user_name: "test1",
          password: "test11234"
        }}
      test1 = User.find_by(user_name: "test1")
      puts test1.inspect
    end
  end
  
  describe "PUT user_path" do
    let!(:test1){ create(:user, user_name: "test1") }
    let!(:test2){ create(:user, user_name: "test2") }
    
    it "updated successfully" do
      # login as test1
      post login_path,
        params: { session: {
          user_name: test1.user_name,
          password: test1.password
        }}
      follow_redirect!
      expect(response.body).to include("Login successfully!!")
      puts test1.reload.inspect
      
      put user_path(test1),
        params: { user: {
          user_name: "test11",
          password: "test14321"
        }}
      follow_redirect!
      expect(response.body).to include("User was successfully updated")
      puts test1.reload.inspect
    end
    
    it "can't be updated because of invalid name or password" do
      # login as test1
      post login_path,
        params: { session: {
          user_name: test1.user_name,
          password: test1.password
        }}
      follow_redirect!
      expect(response.body).to include("Login successfully!!")
      puts test1.reload.inspect

      put user_path(test1),
        params: { user: {
          user_name: "",
          password: ""
        }}
      expect(response.body).to include("Failed to be updated")
      expect(response.body).to include(CGI.escapeHTML("it can't be blank"))
      puts test1.reload.inspect

      put user_path(test1),
        params: { user: {
          user_name: "test3",
          password: "tt"
        }}
      expect(response.body).to include("Failed to be updated")
      expect(response.body).to include(CGI.escapeHTML("it is too short"))
      puts test1.reload.inspect
    end
    
    it "can't be updated because of invalid user" do
      # login as test2
      post login_path,
        params: { session: {
          user_name: test2.user_name,
          password: test2.password
        }}
      follow_redirect!
      expect(response.body).to include("Login successfully!!")
      puts test1.reload.inspect
      
      put user_path(test1),
        params: { user: {
          user_name: "test111",
          password: ""
        }}
      follow_redirect!
      expect(response.body).to include("Invalid access")
      puts test1.reload.inspect
    end
  end

end
