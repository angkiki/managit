require 'rails_helper'

RSpec.describe Feature, type: :model do

  before do
    @user = User.create(email: 'test@test.com', password: '123456', username: 'test')
    @project = Project.create(title: 'test', owner: @user.id )
    @feature = Feature.create(name: 'Test Feature', user: @user, project: @project)
  end

  context "Testing Base & Edge Cases" do
    it "Can Create & Validate" do
      expect( Feature.create ).to_not be_valid
      expect( Feature.create(name: 'Test Feature', user: @user, project: @project) ).to be_valid
    end
  end

  context "Check for AR Associations" do
    it "Belongs to a User & Project" do
      expect(@feature.user).to eq(@user)
      expect(@feature.project).to eq(@project)
    end
  end

  context "Testing Model Methods" do
    it "Can Find Its Owners Name" do
      expect(@feature.owner_name).to eq(@user.username)
      expect( @feature.is_owner_or_not(@user) ).to eq(true)
      expect( Feature.relevant_status ).to eq(['pending', 'bugs'])
    end
  end
end
