require 'rails_helper'

RSpec.describe 'New Viewing Party Page' do
  before do
    user = create(:user)
    movie_id = 120  # Ensure you're passing the movie ID
    stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}")
      .with(
        headers: {
          'Authorization' => "Bearer #{Rails.application.credentials.movie_db[:access_token]}",
          'User-Agent' => 'Faraday v2.10.1'
        }
      )
      .to_return(status: 200, body: File.read('spec/fixtures/movie_details_lotr_fellowship.json'))
  end

  it 'displays the form to create a viewing party' do
    user = create(:user)
    visit new_user_movie_viewing_party_path(user, 120)

    expect(page).to have_content('Create a Viewing Party')
    expect(page).to have_button('Create Party')
  end
end
