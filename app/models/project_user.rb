class ProjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum status: [ :pending, :accepted ]

  after_create :update_status

  private
  # if owner of project is same as user
  # set status to confirmed
  def update_status
    if self.project.owner == self.user.id
      update_columns(status: 1)
    end
  end

end
