require 'rails_helper'

RSpec.describe Apartment, type: :model do
  describe "Apartment" do
    it 'has to be real' do
      expect{Apartment.new}.to_not raise_error
    end
    it "should save" do
      new_apartment = Apartment.new(street_one: "1550 Market", street_two: "", city: "San Diego", postal_code: "92101", state: "CA", country: "USA", contact_name: "Toma", contact_phone: "619-222-2222", contact_hours: "All day errrday")
      new_apartment.save
      expect(new_apartment.street_one).to eq "1550 Market"
      expect(new_apartment.street_two).to eq ""
      expect(new_apartment.city).to eq "San Diego"
      expect(new_apartment.postal_code).to eq "92101"
      expect(new_apartment.state).to eq "CA"
      expect(new_apartment.country).to eq "USA"
      expect(new_apartment.contact_name).to eq "Toma"
      expect(new_apartment.contact_phone).to eq "619-222-2222"
      expect(new_apartment.contact_hours).to eq "All day errrday"
    end
    it "shoud have a latitude and longitude" do
      new_apartment = Apartment.new(street_one: "1550 Market", street_two: "", city: "San Diego", postal_code: "92101", state: "CA", country: "USA", contact_name: "Toma", contact_phone: "619-222-2222", contact_hours: "All day errrday")
      new_apartment.save
      expect(new_apartment.latitude).to be_a Float
      expect(new_apartment.longitude).to be_a Float
    end
  end
end
