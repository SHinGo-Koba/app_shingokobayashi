require 'rails_helper'

RSpec.describe Organizer, type: :model do
  let!(:user1){ create(:user, user_name: "user1") }
  
  it "created organizer through user" do
    organizer = user1.build_organizer(
      organizer_name: user1.user_name,
      )
    expect(organizer).to be_valid
    puts user1.inspect
    puts organizer.inspect
  end

  it "can't be created because of no name" do
    organizer = user1.build_organizer(
      organizer_name: "",
      )
    organizer.valid?
    expect(organizer.errors[:organizer_name]).to include("can't be blank")
  end

  it "can't be created because of too long name" do
    organizer = user1.build_organizer(
      organizer_name: rand(10**13).to_s.rjust(13, "0"),
      )
    organizer.valid?
    expect(organizer.errors[:organizer_name]).to include("is too long (maximum is 12 characters)")
  end

  it "can't be created because of no connection with any user" do
    organizer = Organizer.new(
      user_id: 100000000,
      organizer_name: "test",
      )
    organizer.valid?
    expect(organizer).not_to be_valid
  end
  
  it "created through factory_bot" do
    organizer = create(:organizer)
    expect(organizer).to be_valid
    puts organizer.inspect
    puts organizer.user.inspect
  end

end