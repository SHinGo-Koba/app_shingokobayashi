require 'rails_helper'

RSpec.describe "Projects", type: :request do
  describe "POST projects_path" do
    let!(:user1){ create(:user, user_name: "user1") }
    
    it "created with registerd user" do
      login_as user1 #from support module
      follow_redirect!
      expect(response.body).to include("Login successfully!!")
      
      expect{
        post projects_path,
          params: { project: {
            title: "test",
            summary: "this is test"
          }}
        follow_redirect!
      }.to change{ Project.count }.by(1)
      expect(response.body).to include("Project was successfully created")
      puts user1.reload.inspect
      puts user1.organizer.inspect
      puts user1.reload.organizer.projects.inspect
    end
    
    it "can't be created because of no login yet" do
      post projects_path,
        params: { project: {
          title: "test",
          summary: "this is test"
        }}
      follow_redirect!
      expect(Project.count).to eq(0)
      expect(response.body).to include("Please login")
      puts user1.reload.inspect
      puts user1.organizer.inspect
      puts Project.all.inspect
    end

    it "can't be created because of blank title or summary" do
      login_as user1 #from support module
      follow_redirect!
      expect(response.body).to include("Login successfully!!")

      post projects_path,
        params: { project: {
          title: "",
          summary: "this is test"
        }}
      expect(Project.count).to eq(0)
      expect(response.body).to include("Failed to be created")

      post projects_path,
        params: { project: {
          title: "test",
          summary: ""
        }}
      expect(Project.count).to eq(0)
      expect(response.body).to include("Failed to be created")
      puts user1.reload.inspect
      puts user1.organizer.inspect
      puts Project.all.inspect
    end

    it "can't be created because of too long title or summary" do
      login_as user1 #from support module
      follow_redirect!
      expect(response.body).to include("Login successfully!!")

      post projects_path,
        params: { project: {
          title: rand(10**141).to_s.rjust(141, "0"),
          summary: "this is test"
        }}
      expect(Project.count).to eq(0)
      expect(response.body).to include("Failed to be created")

      post projects_path,
        params: { project: {
          title: "test",
          summary: rand(10**141).to_s.rjust(141, "0")
        }}
      expect(Project.count).to eq(0)
      expect(response.body).to include("Failed to be created")
      puts user1.reload.inspect
      puts user1.organizer.inspect
      puts Project.all.inspect
    end

  end
end
