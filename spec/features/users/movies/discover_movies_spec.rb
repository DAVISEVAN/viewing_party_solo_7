require 'rails_helper'

RSpec.describe 'Discover Movies Page', type: :feature do
  before do
    user = User.create!(name: "Test User", email: "test@example.com")

    stub_request(:get, "https://api.themoviedb.org/3/discover/movie")
      .with(query: hash_including(sort_by: "popularity.desc"))
      .to_return(status: 200, body: File.read('spec/fixtures/top_rated_movies.json'))

    visit user_discover_path(user)
  end

  it 'displays a search field and buttons' do
    expect(page).to have_button('Discover Top Rated Movies')
    expect(page).to have_field('query')
    expect(page).to have_button('Search')
  end
end
