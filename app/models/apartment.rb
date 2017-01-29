class Apartment < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address
  after_validation :geocode
  validates :user, presence: true

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "400x400" }

  validates_attachment :image, presence: true,
    content_type: {
      content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    },
    size: { in: 0..10.megabytes }

  def address
    # @full_address = "#{@street_one}, #{@street_two}, #{@city}, #{@state}, #{@postal_code}, #{@country}"
    self.street_one.to_s + " " + self.street_two.to_s + ", " + self.city.to_s + ", " + self.state.to_s + " " + self.postal_code.to_s + " " + self.country.to_s
  end

  resourcify

end
