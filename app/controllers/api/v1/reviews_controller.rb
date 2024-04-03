class Api::V1::ReviewsController < ApplicationController
    def index
        movie = Movie.find_by(mid: params[:movie_id])
        if movie

            reviews = movie.reviews.map { |review| { user_id: review.user_id, description: review.description } }
            if reviews
            render json: { movie_id: movie.id,review_count: reviews.count, reviews: reviews }
            else
            render json: { error: 'Movie not found' }
            end
        else
            render json: { error: 'Movie not found' }
        end
    end
end
