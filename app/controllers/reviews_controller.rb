class ReviewsController < ApplicationController

    before_action :authenticate_user! && :find_cocktail, except: :show
    
    def find_cocktail
        unless (@cocktail = Cocktail.find_by(:id => params[:cocktail_id]))
            flash[:warning] = "Review must be for an existing cocktail"
            redirect_to cocktails_path
        end
    end

    def index
    end
  
    def update
        @review = Review.find params[:id]
  
        @review.update_attributes!(review_params)
        flash[:notice] = "#{@review.user.username}'s' review was successfullt updated"
        redirect_to cocktail_review_path(@review.id)
      end

    def show
        @review = Review.find(params[:id])
    end

    def new
        @review = @cocktail.reviews.build
    end

    def create
        current_user.reviews << @cocktail.reviews.build(review_params)
        redirect_to cocktail_path(@cocktail)
    end

    def review_params
        params.require(:review).permit(:rate, :comments)
    end

    def destroy
        @review = @cocktail.reviews.find(params[:id])
        @review.destroy
        flash[:notice] = "#{@review.user.username}'s Review deleted"
        redirect_to cocktail_reviews_path(@cocktail)
      end

end
