require 'rails_helper'

RSpec.describe 'Create New User', type: :feature do
  describe 'When user visits "/register"' do
    before(:each) do
      visit register_user_path
    end
    
    it 'creates a new user with valid input and redirects to dashboard' do
      fill_in "user[name]", with: 'Chris'
      fill_in "user[email]", with: 'chris@email.com'
      fill_in "user[password]", with: 'password123'
      fill_in "user[password_confirmation]", with: 'password123'

      click_button 'Create New User'
    
      new_user = User.last

      expect(current_path).to eq(user_path(new_user))
      expect(page).to have_content('Successfully Created New User')
    end

    it 'shows an error if passwords do not match' do
      fill_in "user[name]", with: 'Chris'
      fill_in "user[email]", with: 'chris@email.com'
      fill_in "user[password]", with: 'password123'
      fill_in "user[password_confirmation]", with: 'different_password'

      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it 'shows an error if name or email is missing' do
      fill_in "user[name]", with: ''
      fill_in "user[email]", with: ''
      fill_in "user[password]", with: 'password123'
      fill_in "user[password_confirmation]", with: 'password123'

      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content("Name can't be blank, Email can't be blank")
    end

    it 'shows an error if email is not unique' do
      User.create!(name: 'Tommy', email: 'tommy@example.com', password: 'password123', password_confirmation: 'password123')

      fill_in "user[name]", with: 'Tommy'
      fill_in "user[email]", with: 'tommy@example.com'
      fill_in "user[password]", with: 'password123'
      fill_in "user[password_confirmation]", with: 'password123'

      click_button 'Create New User'

      expect(current_path).to eq(register_user_path)
      expect(page).to have_content('Email has already been taken')
    end
  end
end
