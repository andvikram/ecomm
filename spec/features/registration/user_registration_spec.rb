require 'rails_helper'
require 'support/features/user/session_helpers'

feature "There is a User account registration form -" do

  scenario "Visitor navigates to the User account registration page where the form is displayed with expected fields" do
    visit "/"
    click_link "Login"
    click_link "User Registration"
    expect(page).to have_xpath("//form", id: "new_user_registration")
    within(registration_form) do
      expect(page).to have_field('First Name')
      expect(page).to have_field('Last Name')
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_field('Password confirmation')
    end
  end
end

feature 'Visitor registers account as User' do
  include Features::User::SessionHelpers

  given!(:user) { FactoryGirl.build(:user) }

  scenario 'with valid email and password' do
    form_data = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: Faker::Internet.password
    }

    sign_up_with form_data

    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario 'with invalid email' do
    form_data = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: 'invalid_email',
      password: Faker::Internet.password
    }

    sign_up_with form_data

    expect(page).to have_content('Email is invalid')
  end

  scenario 'with blank password' do
    form_data = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: ''
    }

    sign_up_with form_data

    expect(page).to have_content('Password can\'t be blank')
  end

  ## similarly add tests for other scenarios
end

def registration_form
  '#new_user_registration'
end
