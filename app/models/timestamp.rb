class Timestamp < ApplicationRecord
  belongs_to :timesheet

  def date
    end_time.strftime('%m/%d/%Y')
  end

  def hours
    ((end_time.to_f - start_time.to_f) / 3600).round(2)
  end

  def subtotal
    timesheet.project.hourly_rate * hours
  end
end
