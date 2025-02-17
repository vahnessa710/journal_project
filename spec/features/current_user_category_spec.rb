require 'rails_helper'

RSpec.feature "Journal App Flow" do
  scenario "User signs up, creates a category, adds a task for that category and deletes the task; User adds a task AGAIN to the same category and checks if it is rendered on Tasks for Today Section" do
    #################################################################################
    # User Story #9: As a User, I want to ==sign up== so that I can create an account and link my own tasks.
    #################################################################################
    visit signup_path

    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"
    click_button "Sign Up"

    # After signup, the app automatically logs the user in and redirects to categories#index
    expect(current_path).to eq(categories_path)
    expect(page).to have_content('Click "Title" above to add a category and begin organizing your tasks!')
    expect(page).to have_content('No tasks due today!')
  end
end

