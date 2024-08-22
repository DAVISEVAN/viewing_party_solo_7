require 'rails_helper'

RSpec.describe 'Movies Results Page', type: :feature do
  before do
    user = User.create!(name: "Test User", email: "test@example.com")

    stub_request(:get, "https://api.themoviedb.org/3/search/movie")
      .with(query: hash_including(query: "Lord of the Rings"))
      .to_return(status: 200, body: File.read('spec/fixtures/lord_of_the_rings_movies.json'))

    visit user_movies_path(user, query: "Lord of the Rings")
  end

  it 'displays search results with titles and vote averages' do
    expect(page).to have_content('The Lord of the Rings: The Fellowship of the Ring')
    expect(page).to have_content('Vote Average: 8.4')
  end
end
