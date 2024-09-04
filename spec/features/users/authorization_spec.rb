require 'rails_helper'

RSpec.describe 'Dashboard Authorization', type: :feature do
  before :each do
    @user = User.create!(name: 'Sam', email: 'sam@example.com', password: 'password123', password_confirmation: 'password123')
  end

  it 'redirects to landing page when trying to access dashboard without logging in' do
    visit user_path(@user)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('You must be logged in to access this page')
  end

  it 'allows access to dashboard when logged in' do
    visit login_path

    fill_in :email, with: 'sam@example.com'
    fill_in :password, with: 'password123'
    click_button 'Log In'

    visit user_path(@user)

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_content('Welcome, Sam')
  end
end
