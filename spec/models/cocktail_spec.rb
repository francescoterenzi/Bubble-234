require "rails_helper"

RSpec.describe Cocktail, :type => :model do

  it "Create a cocktail " do
    user = User.create(:first_name => "First", :last_name => "Last", :email => "user@test.it", :password => "123456", :password_confirmation => "123456", :username => "test")
    cocktail = Cocktail.create(:name => "cocktail", :description => "cocktail", :category => "Shaking", :user_id => "#{user.id}")
    expect(Cocktail.first).to eq(cocktail)
  end

  it "Create a cocktail with no name" do
    user = User.create(:first_name => "First", :last_name => "Last", :email => "user@test.it", :password => "123456", :password_confirmation => "123456", :username => "test")
    cocktail = Cocktail.create(:description => "cocktail", :category => "Shaking", :user_id => "#{user.id}")
    expect(cocktail).not_to be_valid
  end

  it "Create a cocktail with no descripton" do
    user = User.create(:first_name => "First", :last_name => "Last", :email => "user@test.it", :password => "123456", :password_confirmation => "123456", :username => "test")
    cocktail = Cocktail.create(:name => "cocktail", :category => "Shaking", :user_id => "#{user.id}")
    expect(cocktail).not_to be_valid
  end

end
