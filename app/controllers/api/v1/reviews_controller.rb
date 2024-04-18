class Api::V1::ReviewsController < ApplicationController
    skip_before_action :verify_authenticity_token
    # before_action :authenticate_user_using_api_key,only: :create
    def index
        movie = Movie.find_by(mid: params[:movie_id])
        if movie
            reviews = movie.reviews.map { |review| { user_id:User.first.id, description: review.description } }
            render json: { movie_id: movie.mid,review_count: reviews.count, reviews: reviews }
        else
            moviecreate=fetch_movie(params[:movie_id])
            if moviecreate['id']
                create_movie_api(moviecreate)
                index()
            elsif moviecreate['status_code']==6 || moviecreate['status_code']==34
                movie_error()
            else
                movie_error()
            end
        end
    end    
    
    def create
        movie = Movie.find_by(mid: params[:movie_id])
        if movie
            reviews = Review.create(review_params.merge(user_id: User.first.id, movie_id: movie.id))
            if reviews.save
                reviews = movie.reviews.map { |review| { user_id: User.first.id, description: review.description } }
                render json: { movie_id: movie.mid, reviews: reviews }
            else
                render json: { error: "Reviews not create" }
            end
        else
            moviecreate=fetch_movie(params[:movie_id])
            if moviecreate['id']
                create_movie_api(moviecreate)
                movie = Movie.find_by(mid: params[:movie_id])
                reviews = Review.create(review_params.merge(user_id: User.first.id, movie_id: movie.id))
                
                if reviews.save
                    reviews = movie.reviews.map { |review| { user_id: User.first.id, description: review.description } }
                    render json: { movie_id: movie.mid, reviews: reviews }
                else
                    render json: { error: "Reviews not create" }
                end
            elsif moviecreate['status_code']==6 || moviecreate['status_code']==34
               movie_error()
            else
                movie_error()
            end
        end
    end

    private

    def fetch_movie(movie_id)
        movieresponse= Tmdb::DetailService.execute(id: movie_id)
    end

    def review_params
        params.require(:review).permit(:description)
    end

    def movie_error
        render json: {error: "Movie not found"},status:404
    end

    def create_movie_api(moviecreate)
        Movie.create(mid: moviecreate['id'], title: moviecreate['title'], original_title: moviecreate['original_title'], overview: moviecreate['overview'],status: moviecreate['status'],
        release_date: moviecreate['release_date'],budget: moviecreate['budget'] ,poster: moviecreate['poster_path'], 
        popularity: moviecreate['popularity'])
    end

    def authenticate_user_using_api_key
        api_key = request.headers['x-api-key']
        @current_user = User.find_by(apikey: api_key)
        unless @current_user
          render json: { error: 'User not authenticated' }, status: :unauthorized
        end
    end
    
end



