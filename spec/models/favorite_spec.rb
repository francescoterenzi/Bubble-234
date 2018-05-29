require 'rails_helper'

RSpec.describe FavoriteCocktail, type: :model do
  it "Create a favorite relationship between users and cocktail" do
    user = User.create(:first_name => "Pinco", :last_name => "Pallino", :email => "test@test.it", :password => "password", :password_confirmation => "password", :username => "test1")
    cocktail = Cocktail.create(:name => "cocktail", :description => "cocktail", :category => "Contemporary Classics", :user_id => "#{user.id}")
    favorite = FavoriteCocktail.create(:user => user, :cocktail => cocktail)
    expect(user.favorites.first).to eq(cocktail)
  end

  it "Create a favorite relationship with missing cocktail" do
    user = User.create(:first_name => "Pinco", :last_name => "Pallino", :email => "test@test.it", :password => "password", :password_confirmation => "password", :username => "test1")
    favorite = FavoriteCocktail.create(:user => user)
    expect(favorite).not_to be_valid
  end
end
