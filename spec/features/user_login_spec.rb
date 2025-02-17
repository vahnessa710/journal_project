require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  let!(:user) { User.create(email: "test@example.com", password: "password", password_confirmation: "password") }

   ###################################################################################
   # User Story #10: As s User, I want to ==login my account== so that I can access my account and link my own tasks.
   ###################################################################################

  scenario "User logs in successfully" do
    visit login_path 

    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    click_button "Login"

    expect(page).to have_content("Start your journal")
    expect(current_path).to eq(categories_path)
    expect(page).to have_content("Today")
  end

  scenario "User fails to log in with invalid credentials" do
    visit login_path

    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "wrongpassword"
    click_button "Login"

    
    expect(page).to have_content("Invalid email or password")
    expect(current_path).to eq(session_path)
  end
end
