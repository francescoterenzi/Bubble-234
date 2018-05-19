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
        respond_to do |format|
          # some other formats like: format.html { render :show }
          format.html.haml
          format.pdf do
            pdf = Prawn::Document.new
            pdf.text "Name: #{@cocktail.name}\nDescription: #{@cocktail.description}\n"
            pdf.image "#{Rails.root}/public#{@cocktail.image}"
            send_data pdf.render,
              filename: "cocktail.pdf",
              type: 'application/pdf',
              disposition: 'inline'
          end
        end
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

      if @cocktail.update_attributes(cocktail_params)
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
        params.require(:cocktail).permit(:name, :description, :user_id, :id, :image, :image_cache, :remove_image)
    end

    end
