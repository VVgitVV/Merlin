class Timestamp < ApplicationRecord
  belongs_to :timesheet

  def calculate_date
    end_time.strftime('%m/%d/%Y')
  end

  def calculate_hours
    ((end_time.to_f - start_time.to_f) / 3600).round(2)
  end
end
