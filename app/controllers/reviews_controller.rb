class ReviewsController < ApplicationController

    before_action :authenticate_user! && :find_cocktail, except: :show
    
    def find_cocktail
        unless (@cocktail = Cocktail.find_by(:id => params[:cocktail_id]))
        end
    end

    def index

    end
  
    def update
        @review = Review.find params[:id]
  
        @review.update_attributes!(review_params)
        flash[:notice] = "Your review was successfully updated"
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
        redirect_to cocktail_reviews_path(@cocktail)
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

    def like
        @review = Review.find params[:id]
        current_user.reviews_liked << @review
        flash[:notice] = "#{@review.user.username}'s Review liked"
        redirect_to cocktail_review_path(@review)
    end
    
    def dislike
        @review = Review.find params[:id]
        current_user.reviews_liked.destroy(@review)
        redirect_to cocktail_review_path(@review)
    end

end
