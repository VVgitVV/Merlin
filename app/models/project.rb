class Project < ApplicationRecord
  belongs_to :client
  has_many :timesheets
  has_many :timestamps, through: :timesheets

  validates :name, :hourly_rate, presence: true

  scope :active, -> { where(archived: false) }

  def toggle_completion!
    update(completed: !completed)
  end
end
