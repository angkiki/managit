class Project < ApplicationRecord
  has_many :project_users
  has_many :users, through: :project_users

  has_many :features

  validates_presence_of :title, :owner

  def add_to_users(user)
    self.users << user
  end

  def is_owner_or_not(user)
    self.owner == user.id
  end

  def get_confirmed_users
    self.users.select { |u| ProjectUser.find_by(user_id: u.id, project_id: self.id).status == "accepted" }
  end

  def get_unconfirmed_users
    self.users.select { |u| ProjectUser.find_by(user_id: u.id, project_id: self.id).status == "pending" }
  end
end
