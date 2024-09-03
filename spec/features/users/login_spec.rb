require 'rails_helper'

RSpec.describe 'User Login Happy Path', type: :feature do
  before :each do
    @user = User.create!(name: 'Sam', email: 'sam@example.com', password: 'password123', password_confirmation: 'password123')
  end

  it 'logs in with valid credentials and redirects to dashboard' do
    visit root_path
    click_link 'Log In'

    expect(current_path).to eq(login_path)

    fill_in :email, with: 'sam@example.com'
    fill_in :password, with: 'password123'
    click_button 'Log In'

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_content("Welcome, Sam")
  end
end


RSpec.describe 'User Login Sad Path', type: :feature do
  before :each do
    @user = User.create(name: 'Sam', email: 'sam@example.com', password: 'password123', password_confirmation: 'password123')
  end

  it 'shows an error with invalid credentials' do
    visit login_path

    fill_in :email, with: 'sam@example.com'
    fill_in :password, with: 'wrongpassword'
    click_button 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Incorrect email or password')
  end
end
