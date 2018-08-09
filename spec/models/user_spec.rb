require 'rails_helper'

RSpec.describe User, type: :model do
  context "Testing Base & Edge Cases" do
    it "Can Create & Validate" do
      expect( User.create(email: 'test@test.com', password: '123456') ).to_not be_valid
      expect( User.create(email: 'test@test.com', password: '123456', username: 'test') ).to be_valid
    end
  end
end
