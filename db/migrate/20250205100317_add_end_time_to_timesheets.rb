class AddEndTimeToTimesheets < ActiveRecord::Migration[7.1]
  def change
    add_column :timesheets, :end_time, :datetime
  end
end
