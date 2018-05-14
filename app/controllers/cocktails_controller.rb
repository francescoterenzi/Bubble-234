class CocktailsController < ApplicationController
   def new
     @cocktail = Cocktail.new
   end

   def create
     params.require(:cocktail)
     permitted = params[:cocktail].permit(:name,:description,:creation_date)

     @cocktail = Cocktail.create!(permitted)
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

end
