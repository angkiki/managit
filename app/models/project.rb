class Project < ApplicationRecord
  has_many :project_users
  has_many :users, through: :project_users

  has_many :features

  validates_presence_of :title, :owner

  def find_owner
    @user = User.find(self.owner)
  end
end
