require "rails_helper"

RSpec.describe CocktailsController, :type => :controller do
  before :each do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "GET index" do
    it "renders the cocktails list" do
      get :index
      expect(response).to render_template(:index)
    end

    it "gives a response status 200" do
      get :index
      expect(response.status).to eq(200)
    end

    it "shows an html page" do
      get :index
      expect(response.content_type).to eq "text/html"
    end
  end

  describe "Create a new cocktail" do
    it "renders the new page" do
      get :new
      expect(response).to render_template(:new)
    end

    it "Creates the cocktail" do
      post :create, params: {cocktail: {name: "Mojito",
      description: "È molto buono",
      user_id: "1",
      category: "Contemporary Classics",
      }}
      expect(response).to redirect_to('/cocktails/1')
    end
  end
end