require 'rails_helper'

RSpec.describe 'Movie Details Page' do
  before do
    # Stub for movie details
    stub_request(:get, "https://api.themoviedb.org/3/movie/120")
      .with(
        headers: {
          'Authorization' => "Bearer #{Rails.application.credentials.movie_db[:access_token]}",
          'User-Agent' => 'Faraday v2.10.1'
        }
      )
      .to_return(status: 200, body: File.read('spec/fixtures/movie_details_lotr_fellowship.json'))

    # Stub for movie credits
    stub_request(:get, "https://api.themoviedb.org/3/movie/120/credits")
      .with(
        headers: {
          'Authorization' => "Bearer #{Rails.application.credentials.movie_db[:access_token]}",
          'User-Agent' => 'Faraday v2.10.1'
        }
      )
      .to_return(status: 200, body: File.read('spec/fixtures/movie_credits_lotr_fellowship.json'))

    # Stub for movie reviews with query parameters
    stub_request(:get, "https://api.themoviedb.org/3/movie/120/reviews?language=en-US&page=1")
      .with(
        headers: {
          'Authorization' => "Bearer #{Rails.application.credentials.movie_db[:access_token]}",
          'User-Agent' => 'Faraday v2.10.1'
        }
      )
      .to_return(status: 200, body: File.read('spec/fixtures/movie_reviews_lotr_fellowship.json'))
  end

  it 'displays the movie details' do
    user = create(:user)
    visit user_movie_path(user, 120)
    expect(page).to have_content('The Lord of the Rings: The Fellowship of the Ring')
  end

  it 'displays the cast members' do
    user = create(:user)
    visit user_movie_path(user, 120)
    expect(page).to have_content('Elijah Wood')
    expect(page).to have_content('Frodo Baggins')
  end

  it 'displays the reviews' do
    user = create(:user)
    visit user_movie_path(user, 120)
    expect(page).to have_content('amazing')
    expect(page).to have_content('movie')
  end
end
