require 'rails_helper'

RSpec.describe 'Root Page, Welcome Index', type: :feature do
  before :each do
    @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com', password: 'password123', password_confirmation: 'password123')
  end

  it 'When a user visits the root path "/" They see title of application, and link back to home page' do
    visit root_path
    expect(page).to have_content('Welcome to Viewing Party!')
    expect(page).to have_link('Home')
  end

  it 'When a user visits the root path "/" They see button to create a New User' do
    visit root_path
    expect(page).to have_link('Register', href: register_user_path)
  end

  it 'When a user visits the root path "/" They see a list of existing users, which links to the individual user\'s dashboard' do
    visit root_path
    expect(page).to have_link(@user_1.name, href: user_path(@user_1))
  end

  it 'When a user visits the root path "/" They see a link to go back to the landing page (present at the top of all pages)' do
    visit root_path
    expect(page).to have_link('Log In', href: login_path)
  end
end
