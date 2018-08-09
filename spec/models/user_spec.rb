require 'rails_helper'

RSpec.describe User, type: :model do

  context "Testing Base & Edge Cases" do
    it "Can Create & Validate" do
      expect( User.create(email: 'test@test.com', password: '123456') ).to_not be_valid
      expect( User.create(email: 'test@test.com', password: '123456', username: 'test') ).to be_valid

      # testing uniqueness of username
      expect( User.create(email: 'test@test.com', password: '123456', username: 'test') ).to_not be_valid
    end
  end

  context "Check for AR Associations" do
    before do
      @user = User.create(email: 'test@test.com', password: '123456', username: 'test')
    end

    it "Has Many Projects" do
      expect(@user.projects).to eq([])
    end

    it "Has Many Features" do
      expect(@user.features).to eq([])
    end
  end
  
end
