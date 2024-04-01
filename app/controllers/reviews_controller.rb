class ReviewsController < ApplicationController
    def create
      @movie = Movie.find_by(id: params[:movie_id])
      
      if @movie.nil?
        @movie= Tmdb::AllService.execute(id: params[:movie_id])
        return
      end
      
      @review= @movie.reviews.create(review_params.merge(user_id: current_user..id))
      if @review.valid?
        redirect_to @movie
      else
        flash[:alert] = "Invalid params"
        redirect_to root_path
      end

    end

    private

    def review_params
      params.require(:review).permit(:description, :movie_id, :user_id)
    end

end



