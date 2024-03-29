class MoviesController < ApplicationController
    def index
      if @movies.present?
        @movies = TmdbSearchService.execute(title: movie_params["title"])
     else
        movies=[]
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
