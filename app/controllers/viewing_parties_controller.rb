class ViewingPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @movie = MovieFacade.find_movie(params[:movie_id].to_i)
    @viewing_party = ViewingParty.new(movie_id: @movie.id)
  end

  def create
    @user = User.find(params[:user_id])
    movie_id = params[:movie_id].to_i

    # Fallback to a default movie_id if something goes wrong
    if movie_id == 0
      flash.now[:alert] = 'Invalid movie selection. Please try again.'
      render :new, status: :unprocessable_entity and return
    end

    @movie = MovieFacade.find_movie(movie_id)
    @viewing_party = ViewingParty.new(viewing_party_params.merge(movie_id: movie_id))

    if @viewing_party.save
      redirect_to user_path(@user), notice: 'Viewing Party created successfully'
    else
      flash.now[:alert] = @viewing_party.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def viewing_party_params
    params.require(:viewing_party).permit(:duration, :date, :start_time)
  end
end
