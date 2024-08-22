class Movie
  attr_reader :id, :title, :vote_average, :runtime, :genres, :overview, :poster_path

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @runtime = data[:runtime]
    @genres = data[:genres]&.map { |genre| genre[:name] } || []
    @overview = data[:overview]
    @poster_path = data[:poster_path]
  end

  def formatted_runtime
    "#{runtime / 60}h #{runtime % 60}m" if runtime
  end
end
