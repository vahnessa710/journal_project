require 'rails_helper'

RSpec.feature "Journal App Flow" do
  scenario "User signs up, creates a category, adds a task for that category and deletes the task; User adds a task AGAIN to the same category and check if it is rendered on Tasks for Today Section" do
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
    expect(page).to have_content("newuser@example.com")
    expect(page).to have_content("Start your journal")

    #################################################################################  
    ## User Story #1: As a User, I want to ==create a category== that can be used to organize my tasks ##
    #################################################################################
    fill_in "Title", with: "Personal"
    click_button "Save"

    #################################################################################
    ## User Story #3: As A User, I want to ==view a category== to show the category's details ##
    #################################################################################

    expect(page).to have_content("Personal")

    # Verify we're on category#show for "Personal"
    expect(current_path).to eq(category_path(Category.last))
    expect(page).to have_content('No tasks for "Personal" yet.')
    expect(page).to have_content('Add New Task')
    #################################################################################
    # User Story #4: As a User, I want to ==create a task for a specific category== so that I can organize tasks quicker
    #################################################################################
    click_link "Add New Task"

    expect(page).to have_content("New Task for Personal")

    fill_in "Name", with: "Buy groceries"
    fill_in "Description", with: "Milk, eggs, and bread"
    fill_in "Due date", with: DateTime.now.strftime("%Y-%m-%dT%H:%M")
    click_button "Create Task"

    #################################################################################
    # User Story #6: As a User, I want to ==view a task== to show task's details
    #################################################################################

    expect(page).to have_content("Buy groceries")
    expect(page).to have_content("Milk, eggs, and bread")
  
    #################################################################################
    # User Story #5: As a User, I want to ==edit a task== to update task's details
    #################################################################################

    click_link "Edit"
    fill_in "Name", with: "Buy groceries"
    fill_in "Description", with: "Milk, eggs, and bread, and cheese"
    click_button "Update Task"
    expect(page).to have_content("cheese")
    expect(page).to have_content("Buy groceries")
    
    #################################################################################
    # User Story #7: As a User, I want to ==delete a task== to lessen my unnecessary daily tasks
    #################################################################################
    click_button "Delete"
    expect(page).to have_content('No tasks for "Personal" yet.')

    # adding task no. 2 for the same category, to check if it will reflect on tasks for today on index page 
    
    click_link "Add New Task"

    expect(page).to have_content("New Task for Personal")

    fill_in "Name", with: "Tinola"
    fill_in "Description", with: "Favourite food"
    fill_in "Due date", with: DateTime.now.strftime("%Y-%m-%dT%H:%M")
    click_button "Create Task"
    expect(page).to have_content("Tinola")


    #################################################################################
     # User Story #2: As a User, I want to ==edit a category== to update the category's details
     #################################################################################

     find("a.link").click
     expect(page).to have_content("Edit Category Name")
     fill_in "category_name", with: "EDITED"
     find("input.save-button").click
     expect(page).to have_content("EDITED")
  
     #################################################################################
     # User Story #8: As a User, I want to ==view my== ==tasks for today== for me to remind what are my priorities for today
     #################################################################################

     click_link "Back to categories"
     expect(page).to have_content("Tasks for Today ⏰")
     expect(page).to have_content("Tinola")
     
  end
end

