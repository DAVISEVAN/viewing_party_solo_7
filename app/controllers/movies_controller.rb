class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    if params[:query].present?
      @movies = MovieFacade.search_movies(params[:query])
    else
      @movies = MovieFacade.top_rated_movies
    end
  end

  def show
    @user = User.find(params[:user_id])
    @movie = MovieFacade.find_movie(params[:id])
    @cast = MovieFacade.movie_cast(params[:id])
    @reviews = MovieFacade.movie_reviews(params[:id])
  end
end
