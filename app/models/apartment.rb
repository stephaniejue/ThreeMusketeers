class Apartment < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode


  def address
    # @full_address = "#{@street_one}, #{@street_two}, #{@city}, #{@state}, #{@postal_code}, #{@country}"
    self.street_one.to_s + " " + self.street_two.to_s + ", " + self.city.to_s + ", " + self.state.to_s + " " + self.postal_code.to_s + " " + self.country.to_s
  end

end
