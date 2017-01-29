require 'rails_helper'

RSpec.feature "Apartments", type: :feature do

  before(:each) do
   @user = User.create(email: "user@email.com", password: "password")
  end

  context 'Apartments homepage' do
    Steps 'Going to the Apartments homepage' do
      Given "I'm on localhost:3000" do
        visit "/"
      end
      Then "I should see 'Apartments'" do
        expect(page).to have_content("Apartment Listings")
      end
    end
  end
  context 'Creating an apartment listing' do
    Steps 'Creating an apartment listing' do
      Given "I'm on localhost:3000 and logged in" do
        visit "/users/sign_in"
      end
      Then 'I can login' do
        fill_in "user_email", with: @user.email
        fill_in "user_password", with: "password"
        click_button "Log in"
      end
      And "I am taken to the Apartments page" do
        expect(page).to have_content("Hello, #{@user.email}")
      end
      Then "I click 'New Apartment'" do
        click_link 'New Apartment'
      end
      Then "I can fill in info for a new apartment listing" do
        fill_in'apartment_street_one', with: '1550 Market'
        fill_in'apartment_street_two', with: ''
        fill_in'apartment_city', with: 'San Diego'
        fill_in'apartment_postal_code', with: '92103'
        fill_in'apartment_state', with: 'CA'
        fill_in'apartment_country', with: 'USA'
        fill_in'apartment_contact_name', with: 'Steph^2'
        fill_in'apartment_contact_phone', with: '123-456-7890'
        fill_in'apartment_contact_hours', with: 'M-W 9-5'
        click_button 'Create Apartment'
      end
      Then "I am taken to page to see new apartment listing" do
        expect(page).to have_content("1550 Market")
        expect(page).to have_content("San Diego")
        expect(page).to have_content("92103")
        expect(page).to have_content("CA")
        expect(page).to have_content("USA")
        expect(page).to have_content("Steph^2")
        expect(page).to have_content("123-456-7890")
        expect(page).to have_content("M-W 9-5")
      end
      And "I can see the listing on a map" do
        # check for map element
        expect(page).to have_css('div#apartment_map')
      end
    end
  end
end
