class Timesheet < ApplicationRecord
  belongs_to :project
  has_many :timestamps
end
