require 'rails_helper'

RSpec.describe User, type: :model do

  it "Create User" do
    user = User.create(:first_name => "First", :last_name => "Last", :email => "user@test.it", :password => "123456", :password_confirmation => "123456", :username => "test")
    expect(User.first).to eq(user)
  end

  it "Validate User" do
    user = User.new(:first_name => "First", :last_name => "Last", :email => "user@test.it", :password => "123456", :password_confirmation => "123456", :username => "test")
    expect(user).to be_valid
  end

  it "Missing First Name" do
    user = User.new(:last_name => "Last", :email => "user@test.it", :password => "123456", :password_confirmation => "123456", :username => "test")
    expect(user).not_to be_valid
  end

  #it "Missing Last Name" do
  #  user = User.new(:first_name => "First", :email => "user@test.it", :password => "123456", :password_confirmation => "123456", :username => "test")
  #  expect(user).not_to be_valid
  #end

  it "Missing Password" do
    user = User.new(:first_name => "First", :last_name => "Last", :email => "user@test.it", :password_confirmation => "123456", :username => "test")
    expect(user).not_to be_valid
  end

  it "Wrong Confirmation" do
    user = User.new(:first_name => "First", :last_name => "Last", :email => "user@test.it", :password => "123456", :password_confirmation => "12456", :username => "test")
    expect(user).not_to be_valid
  end

  it "Missing Email" do
    user = User.new(:first_name => "First", :last_name => "Last", :password => "123456", :password_confirmation => "123456", :username => "test")
    expect(user).not_to be_valid
  end

  it "Missing Username" do
    user = User.new(:first_name => "First", :last_name => "Last", :email => "user@test.it", :password => "123456", :password_confirmation => "123456")
    expect(user).not_to be_valid
  end

  it "Existing Email as Username" do
    user = User.create(:first_name => "First", :last_name => "Last", :email => "user@test.it", :password => "123456", :password_confirmation => "123456", :username => "test")
    user2 = User.create(:first_name => "Altro", :last_name => "Utente", :email => "user2@test.it", :password => "123456", :password_confirmation => "123456", :username => "user@test.it")
    expect(user2).not_to be_valid
  end
end
