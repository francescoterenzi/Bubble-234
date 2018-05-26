require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it "Create a relationship between two users" do
    pippo = User.create(:first_name => "Pinco", :last_name => "Pallino", :email => "test@test.it", :password => "password", :password_confirmation => "password", :username => "test1")
    casa = User.create(:first_name => "First", :last_name => "Last", :email => "user@test.it", :password => "123456", :password_confirmation => "123456", :username => "test2")
    relationship = Relationship.create(:follower_id => pippo.id, :followed_id => casa.id)
    expect(pippo.following.first).to eq(casa)
  end

  it "Create a relationship with missing user" do
    pippo = User.create(:first_name => "Pinco", :last_name => "Pallino", :email => "test@test.it", :password => "password", :password_confirmation => "password", :username => "test1")
    relationship = Relationship.create(:follower_id => pippo.id)
    expect(relationship).not_to be_valid
  end
end
