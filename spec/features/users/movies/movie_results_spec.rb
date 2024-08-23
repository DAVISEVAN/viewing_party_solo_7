require 'rails_helper'

RSpec.describe 'Movies Results Page' do
  it 'displays search results with titles and vote averages' do
    user = create(:user)

    # Stub API request and response
    stub_request(:get, "https://api.themoviedb.org/3/search/movie")
      .with(query: hash_including(query: 'Lord of the Rings'))
      .to_return(status: 200, body: File.read('spec/fixtures/lord_of_the_rings_movies.json'))

    visit user_movies_path(user, query: 'Lord of the Rings')

    expect(page).to have_content('The Lord of the Rings: The Fellowship of the Ring')
    expect(page).to have_content('Vote Average: 8.414')
    expect(page).to have_link('The Lord of the Rings: The Fellowship of the Ring')
  end
end
