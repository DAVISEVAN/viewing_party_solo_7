require 'rails_helper'

RSpec.describe 'Movie Details Page', type: :feature do
  before do
    user = User.create!(name: "Test User", email: "test@example.com")

    stub_request(:get, "https://api.themoviedb.org/3/movie/120")
      .to_return(status: 200, body: File.read('spec/fixtures/movie_details.json'))

    stub_request(:get, "https://api.themoviedb.org/3/movie/120/credits")
      .to_return(status: 200, body: File.read('spec/fixtures/movie_credits.json'))

    stub_request(:get, "https://api.themoviedb.org/3/movie/120/reviews?language=en-US&page=1")
      .to_return(status: 200, body: File.read('spec/fixtures/movie_reviews.json'))

    visit user_movie_path(user, 120)
  end

  it 'displays the movie details' do
    expect(page).to have_content('The Lord of the Rings: The Fellowship of the Ring')
    expect(page).to have_content('Vote Average: 8.4')
    expect(page).to have_content('Runtime: 2h 58m')
    expect(page).to have_content('Genres: Adventure, Fantasy')
    expect(page).to have_content('An epic movie...')
  end

  it 'displays the cast members' do
    expect(page).to have_content('Elijah Wood as Frodo Baggins')
  end

  it 'displays the reviews' do
    expect(page).to have_content('John Doe')
    expect(page).to have_content('An amazing movie...')
  end
end
