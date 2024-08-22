class MovieFacade
  def self.search_movies(query)
    json = MovieService.search_movies(query)
    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def self.top_rated_movies
    json = MovieService.top_rated_movies
    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def self.find_movie(movie_id)
    movie_data = MovieService.get_movie(movie_id)
    Movie.new(movie_data)
  end

  def self.movie_cast(movie_id)
    json = MovieService.get_movie_credits(movie_id)
    json[:cast].first(10).map do |cast_data|
      CastMember.new(cast_data)
    end
  end

  def self.movie_reviews(movie_id)
    json = MovieService.get_movie_reviews(movie_id)
    json[:results].map do |review_data|
      Review.new(review_data)
    end
  end
end
