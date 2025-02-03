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

  def title
    if timestamps.empty? || timestamps.last.end_time.nil?
      created_at.strftime('%B %Y')
    else
      "#{timestamps.first.start_time.strftime('%b %d, %Y')} - #{timestamps.last.end_time.strftime('%b %d, %Y')}"
    end
  end
end
