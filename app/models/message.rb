class Message < ApplicationRecord
  belongs_to :project
  belongs_to :user

  def owner_name
    self.user.username
  end
end
