class ViewingParty < ApplicationRecord
  belongs_to :movie, optional: true
  has_many :user_parties
  has_many :users, through: :user_parties

  validates :duration, presence: true, numericality: { greater_than_or_equal_to: :movie_runtime, message: "must be greater than or equal to the movie runtime" }
  validates :date, presence: true
  validates :start_time, presence: true

  def find_host
    users.where("user_parties.host = true").first
  end

  def movie_runtime
    if movie_id.present? && movie_id != 0
      runtime = MovieFacade.find_movie(movie_id)&.runtime
      runtime || 0
    else
      0
    end
  end
end
