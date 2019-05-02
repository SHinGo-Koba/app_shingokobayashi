require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:project1){ create(:project, title: "project1") }
  let(:user1){ create(:user, user_name: "user1") }

  it "works with valid body, peoject_id and user_id" do
    task = project1.tasks.new(
      body: "this has to be for project1",
      user_id: user1.id,
      )
    expect(task).to be_valid
  end
  
  it "can't be created because of no user" do
    task = project1.tasks.new(
      body: "this has to be denied",
      user_id: 10000000,
      )
    task.valid?
    expect(task.errors[:user]).to include("must exist")
  end
  
  it "can't be created because of no project" do
    task = Task.new(
      body: "this has to be denied",
      user_id: user1.id,
      project_id: 10000000
      )
    task.valid?
    expect(task.errors[:project]).to include("must exist")
  end

  it "can't be created because of no body" do
    task = project1.tasks.new(
      body: "",
      user_id: user1.id,
      )
    task.valid?
    expect(task.errors[:body]).to include("can't be blank")
  end

  it "can't be created because of too long body" do
    task = project1.tasks.new(
      body: rand(10**141).to_s.rjust(141, "0"),
      user_id: user1.id,
      )
    task.valid?
    expect(task.errors[:body]).to include("is too long (maximum is 140 characters)")
  end
  
end
