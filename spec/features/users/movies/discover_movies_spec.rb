require 'rails_helper'

RSpec.describe 'Discover Movies Page' do
  it 'displays a search field and buttons' do
    user = create(:user)

    visit user_discover_index_path(user)

    expect(page).to have_button('Discover Top Rated Movies')
    expect(page).to have_field('query')
    expect(page).to have_button('Search')
  end

  it 'returns search results when a search is performed' do
    user = create(:user)

    # Stub API request and response
    stub_request(:get, "https://api.themoviedb.org/3/search/movie")
      .with(query: hash_including(query: 'Lord of the Rings'))
      .to_return(status: 200, body: File.read('spec/fixtures/lord_of_the_rings_movies.json'))

    visit user_discover_index_path(user)

    fill_in 'query', with: 'Lord of the Rings'
    click_button 'Search'

    expect(page).to have_content('The Lord of the Rings: The Fellowship of the Ring')
    expect(page).to have_content('Vote Average: 8.414')
  end
end
