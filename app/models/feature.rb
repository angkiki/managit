class Feature < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates_presence_of :name

  enum status: [ :pending, :completed, :bugs ]
end
