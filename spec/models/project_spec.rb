require 'rails_helper'

RSpec.describe Project, type: :model do
  let!(:organizer1){ create(:organizer) }
  
  it "created with valid title and summary" do
    project = organizer1.projects.new(
      title: "this is test project",
      summary: "test"
    )
    expect(project).to be_valid
    puts organizer1.inspect
    puts organizer1.user.inspect
    puts organizer1.projects.inspect
  end
  
  it "can't be created because of no title or summary" do
    project1 = organizer1.projects.new(
      title: "",
      summary: "test"
    )
    project1.valid?
    expect(project1.errors[:title]).to include("can't be blank")
    
    project2 = organizer1.projects.new(
      title: "title",
      summary: ""
    )
    project2.valid?
    expect(project2.errors[:summary]).to include("can't be blank")
  end

  it "can't be created because of too long title or summary" do
    project1 = organizer1.projects.new(
      title: rand(10**141).to_s.rjust(141, "0"),
      summary: "test"
    )
    project1.valid?
    expect(project1.errors[:title]).to include("is too long (maximum is 140 characters)")
    
    project2 = organizer1.projects.new(
      title: "title",
      summary: rand(10**141).to_s.rjust(141, "0")
    )
    project2.valid?
    expect(project2.errors[:summary]).to include("is too long (maximum is 140 characters)")
  end
  
end
