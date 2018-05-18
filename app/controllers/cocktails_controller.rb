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

      if @cocktail.update_attributes(permitted)
        flash[:notice] = "#{@cocktail.name} was successfullt updated"
        redirect_to cocktail_path(@cocktail)
      else
        render 'edit'
      end
    end

    def favorite
        @cocktail = Cocktail.find params[:id]
        type = params[:type]
        if type == "favorite"
          current_user.favorites << @cocktail
          redirect_back fallback_location: root_path, notice: "#{@cocktail.name} added to Favorites"

        elsif type == "unfavorite"
          current_user.favorites.delete(@cocktail)
          redirect_back fallback_location: root_path, notice: "#{@cocktail.name} removed from Favorites"

        else
          # Type missing, nothing happens
          redirect_to :back, notice: 'Nothing happened.'
        end
    end

    def cocktail_params
        params.require(:cocktail).permit(:name,:description,:user_id,:id,:image, :image_cache, :remove_image)
    end

    end
