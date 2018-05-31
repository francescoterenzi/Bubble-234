class CocktailsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index, :results]
    helper_method :find_following_cocktails

    def find_following_cocktails
        f_cocktails = Array.new
        current_user.following.each do |user|
            f_cocktails.concat(user.cocktails)
        end
        f_cocktails.flatten.sort_by(&:created_at).reverse
    end

    def index
      @newest = Cocktail.all.order('created_at DESC')
      @best = []
      Cocktail.all.each { |c| @best << c if c.media >= 3 }
      @best = @best.sort_by{|cocktail| cocktail.media}.reverse
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
              if @cocktail.image.url.include? "public"
                pdf.image "#{Rails.root}/public#{@cocktail.image}",:scale => 0.5
              end
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
        redirect_to user_path(current_user)
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

    def random
      @cocktails = Cocktail.where("user_id <> ?", current_user)
      if @cocktails.size == 0
        flash[:notice] = "No cocktails!"
        redirect_to root_path
      else
        @cocktail = @cocktails.sample
        render 'show'
      end
    end

    def update
      begin
        @cocktail = Cocktail.find params[:id]
        if !(params[:cocktail][:link].blank?) && (params[:cocktail][:link] != @cocktail.link)
          @cocktail.video = Video.new(video_params) unless frozen?
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
          #if !current_user.favorites.include? @cocktail 
          current_user.favorites << @cocktail
          #end
          redirect_back fallback_location: root_path, notice: "#{@cocktail.name} added to Favorites"

        elsif type == "unfavorite"
          current_user.favorites.delete(@cocktail)
          redirect_back fallback_location: root_path, notice: "#{@cocktail.name} removed from Favorites"

        else
          # Type missing, nothing happens
          redirect_to :back, notice: 'Nothing happened.'
        end
    end

    def results
      @keywords = params[:words]
      @category = params[:category]
      @orderby = params[:orderby]
      if @category != ""
        @cocktails = Cocktail.where("(name like ? or description like ?) and category like ?", "%#{@keywords}%", "%#{@keywords}%" , "#{@category}")
      else
        @cocktails = Cocktail.where("name like ? or description like ?", "%#{@keywords}%", "%#{@keywords}%")
      end
      if(@orderby == 'A-Z')
        @cocktails = @cocktails.sort_by(&:name)
      elsif(@orderby == 'Most Recent')
        @cocktails = @cocktails.sort_by(&:created_at).reverse
      elsif(@orderby == 'Top Rating')
        @cocktails = @cocktails.sort_by{|cocktail| cocktail.media}.reverse
      elsif(@orderby == 'Most Reviewed')
        @cocktails = @cocktails.sort_by{|cocktail| cocktail.reviews.count}.reverse
      end

      if @cocktails.size == 0
        flash[:warning] = 'No cocktails found!'
        redirect_to root_path
      end
    end

    def cocktail_params
        params.require(:cocktail).permit(:name, :description, :user_id, :id, :image, :image_cache, :remove_image, :link, :video_id, :category)
    end

    def video_params
        params.require(:cocktail).permit(:link)
    end

end
