require 'rails_helper'

RSpec.describe 'Viewing Party Authorization', type: :feature do
  before :each do
    @user = User.create!(name: 'Sam', email: 'sam@example.com', password: 'password123', password_confirmation: 'password123')
    @movie_id = 1
  end

  it 'redirects a visitor trying to create a viewing party to the movie show page' do
    visit user_movie_path(@user, @movie_id)

    click_button 'Create Viewing Party'

    expect(current_path).to eq(user_movie_path(@user, @movie_id))
    expect(page).to have_content('You must be logged in to create a viewing party')
  end
end
