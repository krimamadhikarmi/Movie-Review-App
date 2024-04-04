class Api::V1::ReviewsController < ApplicationController
    def index
        movie = Movie.find_by(mid: params[:movie_id])
        if movie
            reviews = movie.reviews.map { |review| { user_id: review.user_id, description: review.description } }
            render json: { movie_id: movie.mid,review_count: reviews.count, reviews: reviews }
        else
            moviecreate=fetch_movie(params[:movie_id])
            if moviecreate['id']
                Movie.create(mid: moviecreate['id'], title: moviecreate['title'], original_title: moviecreate['original_title'], overview: moviecreate['overview'],status: moviecreate['status'],release_date: moviecreate['release_date'],budget: moviecreate['budget'] ,poster: moviecreate['poster_path'], popularity: moviecreate['popularity'])
                index()
            elsif moviecreate['statuss_code']==6 || moviecreate['status_code']==34
                render json: {error: "Movie not found"},status:404
            else
                render json: {error: "Movie not found"},status:404
            end
        end
    end      
    private

    def fetch_movie(movie_id)
        movieresponse= Tmdb::DetailService.execute(id: movie_id)
    end
end



