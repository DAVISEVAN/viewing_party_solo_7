require 'rails_helper'

RSpec.describe 'Remember User with Session', type: :feature do
  before :each do
    @user = User.create!(name: 'Sam', email: 'sam@example.com', password: 'password123', password_confirmation: 'password123')
  end

  it 'logs in a user and remembers them across visits' do
    visit login_path

    fill_in :email, with: 'sam@example.com'
    fill_in :password, with: 'password123'
    fill_in :location, with: 'Denver, CO'
    click_button 'Log In'

    expect(page).to have_content('Welcome, Sam')

    
    visit root_path

    expect(page).to have_link('Log Out')
    expect(page).to_not have_link('Log In')

    click_link 'Log Out'
    expect(page).to have_link('Log In')
  end
end
