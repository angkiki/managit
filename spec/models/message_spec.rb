require 'rails_helper'

RSpec.describe Message, type: :model do

  before do
    @user = User.create(email: 'test@test.com', password: '123456', username: 'test')
    @project = Project.create(title: 'test', owner: @user.id )
  end

  context "Testing Cases" do
    it "Can Create & Validate" do
      expect( Message.create(message: 'hello world', user: @user, project: @project) ).to be_valid
    end
  end

  context "Testing AR Associations" do
    it "Belongs to User and Project" do
      @message = Message.create(message: 'hello world', user: @user, project: @project)

      expect(@message.user).to eq(@user)
      expect(@message.project).to eq(@project)
    end
  end
end
