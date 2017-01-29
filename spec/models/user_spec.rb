require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User can be made" do
    it "exists" do
      expect{User.new}.to_not raise_error
    end
    it "should save to db" do
      u = User.new(email: "email@home.com", password: "password")
      expect(u.save).to eq true
      expect(u.email).to eq "email@home.com"
    end
  end
end
