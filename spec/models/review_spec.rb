require "rails_helper"

RSpec.describe Review, :type => :model do

  it "Create a review for a cocktail" do
    user = User.create(:first_name => "Pinco", :last_name => "Pallino", :email => "test@test.it", :password => "password", :password_confirmation => "password", :username => "test")
    cocktail = Cocktail.create(:name => "Mojito", :description => "Cuban cocktail",:user_id => user.id)
    review = cocktail.reviews.create(:rate => 3, :comments => "very good", :user_id => user.id)
    expect(cocktail.reload.reviews.first).to eq(review)
  end

  it "Create a review without rate" do
    user = User.create(:email => "test@test.it", :password => "password", :password_confirmation => "password", :username => "test")
    cocktail = Cocktail.create(:name => "Mojito", :description => "Cuban cocktail", :user_id => user.id)
    review = Review.new(:comments => "very good", :user_id => user.id)
    expect(review).not_to be_valid
  end

  it "Create a review with 0 or less rate" do
    user = User.create(:email => "test@test.it", :password => "password", :password_confirmation => "password", :username => "test")
    cocktail = Cocktail.create(:name => "Mojito", :description => "Cuban cocktail", :user_id => user.id)
    review = Review.new(:rate => 0, :comments => "very good", :user_id => user.id)
    expect(review).not_to be_valid
  end

  it "Create a review with bigger than 5 rate" do
    user = User.create(:email => "test@test.it", :password => "password", :password_confirmation => "password", :username => "test")
    cocktail = Cocktail.create(:name => "Mojito", :description => "Cuban cocktail", :user_id => user.id)
    review = Review.new(:rate => 6, :comments => "very good", :user_id => user.id)
    expect(review).not_to be_valid
  end

  it "Create a review with not integer 5 rate" do
    user = User.create(:email => "test@test.it", :password => "password", :password_confirmation => "password", :username => "test")
    cocktail = Cocktail.create(:name => "Mojito", :description => "Cuban cocktail", :user_id => user.id)
    review = Review.new(:rate => 3.5, :comments => "very good", :user_id => user.id)
    expect(review).not_to be_valid
  end

end
