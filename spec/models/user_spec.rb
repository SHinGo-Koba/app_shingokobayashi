require 'rails_helper'

RSpec.describe User, type: :model do
  it "works with valid name and password" do
    user = User.new(
      user_name: "test1",
      password: "test11234",
      password_confirmation: "test11234"
    )
    expect(user).to be_valid
  end
  
  it "doesn't work because of no name" do
    user = User.new(
      user_name: "",
      password: "test11234",
      password_confirmation: "test11234"
    )
    user.valid?
    expect(user.errors[:user_name]).to include("can't be blank") 
  end
  
  it "doesn't work because of nil in name" do
    user = User.new(
      user_name: nil,
      password: "test11234",
      password_confirmation: "test11234"
    )
    user.valid?
    expect(user.errors[:user_name]).to include("can't be blank")
  end

  it "doesn't work because of too long name" do
    user = User.new(
      user_name: rand(10**13).to_s.rjust(13, "0"),
      password: "test11234",
      password_confirmation: "test11234"
    )
    user.valid?
    expect(user.errors[:user_name]).to include("is too long (maximum is 12 characters)")
  end

  it "doesn't work because of already exsisted name" do
    user = User.create(
      user_name: "test1",
      password: "test11234",
      password_confirmation: "test11234"
    )
    expect(user).to be_valid
    user1 = User.new(
      user_name: "test1",
      password: "test14321",
      password_confirmation: "test14321"
    )
    user1.valid? 
    expect(user1.errors[:user_name]).to include("has already been taken")
  end

  
  it "doesn't work because of blank of password" do
    user = User.new(
      user_name: "test1",
      password: "",
      password_confirmation: ""
    )
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
  
  it "doesn't work because of nil in password" do
    user = User.new(
      user_name: "test1",
      password: nil,
      password_confirmation: nil
    )
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "doesn't work because of not allowed white space in password" do
    user = User.new(
      user_name: "test1",
      password: "      ",
      password_confirmation: "      "
    )
    user.valid?
    expect(user.errors[:password]).to include("only arrows letters and numbers")
  end

  it "doesn't work because of too short password" do
    user = User.new(
      user_name: "test1",
      password: "ttttt",
      password_confirmation: "ttttt"
    )
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it "doesn't work because of too long password" do
    set_password = rand(10**11).to_s.rjust(11, "0")
    user = User.new(
      user_name: "test1",
      password: set_password,
      password_confirmation: set_password
    )
    user.valid?
    expect(user.errors[:password]).to include("is too long (maximum is 10 characters)")
  end

  it "doesn't work because of unmatch password_confirmation" do
    user = User.new(
      user_name: "test1",
      password: "test11234",
      password_confirmation: "test14321"
    )
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  it "doesn't work because of blank in password_confirmation" do
    user = User.new(
      user_name: "test1",
      password: "test11234",
      password_confirmation: ""
    )
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

end
