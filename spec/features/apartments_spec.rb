require 'rails_helper'

RSpec.feature "Apartments", type: :feature do
  context 'Apartments page' do
    Steps 'Going to the Apartments homepage' do
      Given "I'm on localhost:3000" do
        visit "/"
      end
      Then "I should see 'Apartments'" do
        expect(page).to have_content("Apartments")
      end
    end
  end
end
