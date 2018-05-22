class CocktailsController < ApplicationController
    before_action :authenticate_user!, except: :show

    def index
    end

    def new
        @cocktail = current_user.cocktails.build
    end

    def create

        @cocktail = current_user.cocktails.build(cocktail_params)
        @cocktail.video = Video.new(video_params)
        if @cocktail.save
            flash[:notice] = "'#{@cocktail.name}' was successfully created!"
            redirect_to cocktail_path(@cocktail)
        else
            render 'new'
        end
    end

    def show
      begin
        id = params[:id]
        @cocktail = Cocktail.find(id)
        respond_to do |format|
          # some other formats like: format.html { render :show }
          format.html.haml
          format.pdf do
            pdf = Prawn::Document.new(:page_layout => :landscape)
            pdf.text "Details about cocktail '#{@cocktail.name}'\n", :size => 29, :align => :center
            pdf.text "Created by '#{@cocktail.user.username}'\n\n\n", :size => 20, :align => :center
            pdf.text "Description: #{@cocktail.description}\n\n", :size => 20
            if !@cocktail.image.nil?
              pdf.image "#{Rails.root}/public#{@cocktail.image}",:scale => 0.7
            end
            send_data pdf.render,
              filename: "cocktail.pdf",
              type: 'application/pdf',
              disposition: 'inline'
          end
        end
      rescue ActiveRecord::RecordNotFound => e
        redirect_to root_path, flash: {:alert => 'No cocktail found'}
      end
    end

    def destroy
      begin
        @cocktail = Cocktail.find(params[:id])
        @cocktail.destroy
        flash[:notice] = "Cocktail '#{@cocktail.name}' deleted."
        redirect_to users_myprofile_path
      rescue ActiveRecord::RecordNotFound => e
        redirect_to root_path, flash: {:alert => 'No cocktail found'}
      end
    end

    def edit
      begin
        @cocktail = Cocktail.find params[:id]
      rescue ActiveRecord::RecordNotFound => e
        redirect_to root_path, flash: {:alert => 'No cocktail found'}
      end
    end

    def update
      begin
        @cocktail = Cocktail.find params[:id]
        if !(params[:link].blank?)
          @cocktail.video = Video.new(video_params)
        end

        if @cocktail.update_attributes(cocktail_params)
          flash[:notice] = "#{@cocktail.name} was successfully updated"
          redirect_to cocktail_path(@cocktail)
        else
          render 'edit'
        end
      rescue ActiveRecord::RecordNotFound => e
        redirect_to root_path, flash: {:alert => 'No cocktail found'}
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
        params.require(:cocktail).permit(:name, :description, :user_id, :id, :image, :image_cache, :remove_image, :link, :video_id)
    end

    def video_params
        params.require(:cocktail).permit(:link)
    end

    end
