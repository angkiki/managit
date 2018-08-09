require 'rails_helper'

RSpec.describe Project, type: :model do

  before do
    @user = User.create(email: 'test@test.com', password: '123456', username: 'test')
    @user2 = User.create(email: 'test2@test.com', password: '123456', username: 'test2')
    @project = Project.create(title: 'test', owner: @user.id )
  end

  context "Testing Base & Edge Cases" do
    it "Can Create & Validate" do
      expect( Project.create ).to_not be_valid
      expect( Project.create(title: 'test', owner: @user.id) ).to be_valid
    end
  end

  context "Testing AR Associations" do
    it "Has Many Users" do
      expect(@project.users).to eq([])

      @project.users << [ @user, @user2 ]
      expect(@project.users.count).to eq(2)
      expect(@project.users.first).to eq(@user)

      # testing project_users after_create callback
      @project_users = ProjectUser.find_by(project: @project, user: @user)
      expect(@project_users.status).to eq("accepted")

      @project_users2 = ProjectUser.find_by(project: @project, user: @user2)
      expect(@project_users2.status).to eq("pending")
    end

    it "Has Many Feautres" do
      expect(@project.features).to eq([])
    end
  end

  context "Testing Model Methods" do
    it "Can Find Its Owner" do
      expect(@project.find_owner).to eq(@user)
    end
  end
  
end
