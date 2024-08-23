require 'rails_helper'

RSpec.describe 'New Viewing Party Page', type: :feature do
  before :each do
    @user = create(:user)
    @movie_id = 120
    @movie = Movie.new(id: @movie_id, title: "The Lord of the Rings: The Fellowship of the Ring", runtime: 180)

    allow(MovieFacade).to receive(:find_movie).with(@movie_id).and_return(@movie)
  end

  it 'displays the movie title and a form to create a new viewing party' do
    visit new_user_movie_viewing_party_path(@user, @movie_id)

    expect(page).to have_content('The Lord of the Rings: The Fellowship of the Ring')
    expect(page).to have_field('Duration of Party', with: @movie.runtime)
    expect(page).to have_field('When')
    expect(page).to have_field('Start Time')
    expect(page).to have_field('guest_1_email')
    expect(page).to have_field('guest_2_email')
    expect(page).to have_field('guest_3_email')
  end

  it 'redirects to the user dashboard with the new event' do
    visit new_user_movie_viewing_party_path(@user, @movie_id)

    fill_in 'Duration of Party', with: 180
    fill_in 'When', with: '2024-12-31'
    fill_in 'Start Time', with: '19:00'
    fill_in 'guest_1_email', with: 'guest1@example.com'
    click_button 'Create Viewing Party'

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_content('Viewing Party created successfully')
  end

  it 'displays validation errors if the form is submitted with invalid data' do
    visit new_user_movie_viewing_party_path(@user, @movie_id)

    fill_in 'Duration of Party', with: 120 # less than the movie runtime
    click_button 'Create Viewing Party'

    expect(page).to have_content("Duration must be greater than or equal to the movie runtime")
  end
end

