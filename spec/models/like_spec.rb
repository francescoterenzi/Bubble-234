require 'rails_helper'

RSpec.describe Like, type: :model do
  it "Create a like relationship between users and a review by user itself" do
    user = User.create(:first_name => "Pinco", :last_name => "Pallino", :email => "test@test.it", :password => "password", :password_confirmation => "password", :username => "test1")
    cocktail = Cocktail.create(:name => "Mojito", :description => "Cuban cocktail",:user_id => user.id, :category => "Contemporary Classics")
    review = cocktail.reviews.create(:rate => 3, :comments => "very good", :user_id => user.id)
    like = Like.create(:user => user, :review => review)
    expect(user.likes.first).to eq(like)
  end

  it "Create a like relationship with missing review" do
    user = User.create(:first_name => "Pinco", :last_name => "Pallino", :email => "test@test.it", :password => "password", :password_confirmation => "password", :username => "test1")
    like = Like.create(:user => user)
    expect(like).not_to be_valid
  end
end
