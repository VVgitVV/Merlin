class Timesheet < ApplicationRecord
  belongs_to :project
  has_many :timestamps

  def total
    count = 0
    timestamps.each do |timestamp|
      count += timestamp.subtotal unless timestamp.end_time.nil?
    end
    format('%.2f', count)
  end
end
