class Api::V1::MovieReviewsController < ApplicationController
    skip_before_action :verify_authenticity_token
   
    def index
        all = params[:movie_id]
        if all
            movies= Movie.includes(:reviews).all
            render json: movies,include: :reviews
        end
            
    end    
end

