class Api::V1::MovieReviewsController < ApplicationController
  def index
    reviews = Review.all
    render json:  reviews.as_json(except: [:id, :created_at ,:updated_at]),status:200
  end

  def show
    movie_review = Movie.find_by(mid: params[:id]) #movie ko id lincha whole row nai
  
    if movie_review.present?
      review= Review.where(movie_id: movie_review.id)  #tyo row ko id matra review lai dincha
      render json:  review.as_json(except: [:id, :created_at ,:updated_at]),status:200
    else
      render json: {error: "Not Found"},status:404
    end

  end
  
  private

  def review_params
    params.require(:review).permit([
      :description, :user_id, :movie_id
    ])
  end
end
