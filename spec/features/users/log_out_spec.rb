require 'rails_helper'

RSpec.describe 'Log Out', type: :feature do
  before :each do
    @user = User.create!(name: 'Sam', email: 'sam@example.com', password: 'password123', password_confirmation: 'password123')
  end

  it 'logs out a user and clears the session' do
    visit login_path

    fill_in :email, with: 'sam@example.com'
    fill_in :password, with: 'password123'
    click_button 'Log In'

    expect(page).to have_link('Log Out')
    expect(page).to_not have_link('Log In')

    click_link 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to have_link('Log In')
    expect(page).to_not have_link('Log Out')
  end
end
