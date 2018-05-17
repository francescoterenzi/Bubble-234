class CocktailsController < ApplicationController
    before_action :authenticate_user!, except: :show

    def new
        @cocktail = current_user.cocktails.build
    end

    def create
        @cocktail = current_user.cocktails.build(cocktail_params)
        if @cocktail.save
            redirect_to cocktail_path(@cocktail)
        else
            render 'new'
        end
    end

    def show
     id = params[:id]
     @cocktail = Cocktail.find(id)
    end

    def destroy
      @cocktail = Cocktail.find(params[:id])
      @cocktail.destroy
      flash[:notice] = "Cocktail '#{@cocktail.name}' deleted."
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
        params.require(:cocktail).permit(:name,:description,:user_id,:id,:image)
    end

    end
