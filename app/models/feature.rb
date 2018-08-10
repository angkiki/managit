class Feature < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates_presence_of :name

  enum status: [ :pending, :bugs, :completed ]

  # method to return relevant statuses for creating new feature
  def self.relevant_status
    self.statuses.first(2).map { |status| status[0] }
  end
end
