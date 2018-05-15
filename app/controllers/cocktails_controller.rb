class CocktailsController < ApplicationController
    #before_action :authenticate_user!, except: :show
    before_action :has_user, :only => [:new, :create]
    protected
    def has_user
        unless current_user
            flash[:warning] = 'You must be logged in to create new cocktails.'
            redirect_to new_user_session_path
        end
        unless (@user = User.find(:id => params[:user_id]))
            flash[:warning] = 'Cocktails must be created from an existing user'
            redirect_to root_path
        end
    end

    public
    def new
     @cocktail = @user.cocktails.build
    end

    def create
     current_user.cocktails << @user.cocktails.build(params[:cocktail])
     redirect_to cocktail_path(@cocktail)
    end

    def show
     id = params[:id]
     @cocktail = Cocktail.find(id)
    end

    def destroy
      @cocktail = Cocktail.find(params[:id])
      @cocktail.destroy
      flash[:notice] = "Movie '#{@cocktail.name}' deleted."
      redirect_to root_path
    end

    def edit
      @cocktail = Cocktail.find params[:id]
    end

    def update
      @cocktail = Cocktail.find params[:id]
      params.require(:cocktail)
      permitted = params[:cocktail].permit(:name,:description,:creation_date)

      @cocktail.update_attributes!(permitted)
      flash[:notice] = "#{@cocktail.name} was successfullt updated"
      redirect_to cocktail_path(@cocktail)
    end

    def cocktail_params
    params.require(:cocktail).permit(:name,:description,:creation_date,:user_id,:id)
    end

    end
