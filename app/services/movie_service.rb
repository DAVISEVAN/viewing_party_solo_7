require 'faraday'
class MovieService

  def self.search_movies(query)
    response = connection.get('search/movie') do |req|
      req.params['query'] = query
      req.params['include_adult'] = false
    end
    parse_response(response)
  end

  def self.top_rated_movies
    response = connection.get('discover/movie') do |req|
      req.params['sort_by'] = 'popularity.desc'
      req.params['include_adult'] = false
      req.params['page'] = 1
    end
    parse_response(response)
  end

  def self.get_movie(movie_id)
    response = connection.get("movie/#{movie_id}")
    parse_response(response)
  end

  def self.get_movie_credits(movie_id)
    response = connection.get("movie/#{movie_id}/credits")
    parse_response(response)
  end

  def self.get_movie_reviews(movie_id)
    response = connection.get("movie/#{movie_id}/reviews") do |req|
      req.params['language'] = 'en-US'
      req.params['page'] = 1
    end
    parse_response(response)
  end

  private

  def self.connection
    Faraday.new(url: 'https://api.themoviedb.org/3') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{Rails.application.credentials.movie_db[:access_token]}"
    end
  end

  def self.parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

