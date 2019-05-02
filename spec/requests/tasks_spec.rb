require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "POST project_tasks" do
    let!(:project1){ create(:project, title: "test") }
    let!(:user1){ create(:user, user_name: "user1") }
    let(:user2){ create(:user, user_name: "user2") }
    
    it "works with valid data" do
      login_as user1
      follow_redirect!
      expect(response.body).to include("Login successfully!!")
      
      expect{
        post project_tasks_path(project1),
          params: { task: {
            body: "this is related to project1"
          }}
      }.to change{ Task.count }.by(1)
      expect(response).to redirect_to project_path(project1)
      follow_redirect!
      expect(response.body).to include("Committed to this project!")
    end
    
    it "can't be created because of no login" do
      post project_tasks_path(project1),
        params: { task: {
          body: "this is related to project1"
        }}
      expect(response).to redirect_to login_path
      follow_redirect!
      expect(response.body).to include("Please login")
    end

    it "can't be created because of no body" do
      login_as user1
      follow_redirect!
      expect(response.body).to include("Login successfully!!")

      post project_tasks_path(project1),
        params: { task: {
          body: ""
        }}
      expect(response).to have_http_status(200)
      expect(response.body).to include("Failed to be created")
    end

    it "can't be created because of another param user_id" do
      login_as user1
      follow_redirect!
      expect(response.body).to include("Login successfully!!")

      post project_tasks_path(project1),
        params: { task: {
          body: "this is related to project1",
          user_id: user2.id
        }}
      expect(response).to redirect_to projects_path
      follow_redirect!
      expect(response.body).to include("Invalid access")
      puts project1.reload.tasks.inspect
      expect(project1.reload.tasks.empty?).to eq true
    end
    
  end
end
