class Timestamp < ApplicationRecord
  belongs_to :timesheet
  has_one :project, through: :timesheet

  def date
    end_time&.strftime('%m/%d/%Y %H:%M')
  end

  def hours
    return 0 if end_time.nil?

    ((end_time.to_f - start_time.to_f) / 3600).round(2)
  end

  def subtotal
    return 0 if end_time.nil?

    timesheet.project.hourly_rate * hours
  end
end
