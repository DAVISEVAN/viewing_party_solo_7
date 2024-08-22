class ViewingPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @movie = MovieFacade.find_movie(params[:movie_id])
    
  end

  def create
    
  end
end
