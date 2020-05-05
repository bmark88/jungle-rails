require 'rails_helper'

RSpec.feature "User can successfully login and is redirected to the home page", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create! email: 'test@gmail.com', password: 'test', password_confirmation: 'test', name: 'Bob Smith'
  end

  scenario "They see all products" do
    visit login_path

    fill_in 'email', with: 'test@gmail.com'
    fill_in 'password', with: 'test'
    
    page.find(:button, 'Submit').click
    # commented out b/c it's for debugging only
    # sleep 1
    # save_and_open_screenshot

    expect(page).to have_text 'Logout'
  end
end
