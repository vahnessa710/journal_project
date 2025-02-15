require 'rails_helper'

RSpec.feature "UserSignups", type: :feature do
  scenario "User signs up successfully" do
    visit signup_path  # Ensure your routes map signup_path to Users#new

    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"
    click_button "Sign Up"

    expect(page).to have_content("Start your journal")
    # Optionally, check that the user is redirected to the categories index
    expect(current_path).to eq(categories_path)
  end

  scenario "User fails to sign up without email" do
    visit signup_path

    fill_in "Email", with: ""
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"
    click_button "Sign Up"

    expect(page).to have_content("Email can't be blank")
  end
end
