class Project < ApplicationRecord
  belongs_to :client
  has_many :timesheets

  validates :name, :hourly_rate, presence: true
end
