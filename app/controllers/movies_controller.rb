class MoviesController < ApplicationController
    before_action :authenticate_user!
    def index
      if params[:movie_title].present?
        @movies = Tmdb::SearchService.execute(title: params[:movie_title])
      else
        @movies=[]
      end
    end

    def create
        @title =Movie.create(movie_params)
        redirect_to root_path
    end
  
    private
    def movie_params
        params.require(:movie).permit(:title)
    end
end
