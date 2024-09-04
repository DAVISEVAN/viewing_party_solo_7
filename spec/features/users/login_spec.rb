require 'rails_helper'

RSpec.describe 'Login with Location', type: :feature do
  before :each do
    @user = User.create!(name: 'Sam', email: 'sam@example.com', password: 'password123', password_confirmation: 'password123')
  end

  it 'stores location in a cookie and shows it on login page' do
    visit login_path

    fill_in :email, with: 'sam@example.com'
    fill_in :password, with: 'password123'
    fill_in :location, with: 'Denver, CO'
    click_button 'Log In'

    expect(page).to have_content('Welcome, Sam')

    click_link 'Log Out'
    visit login_path

    
    expect(find_field('Location').value).to eq('Denver, CO')
  end
end
