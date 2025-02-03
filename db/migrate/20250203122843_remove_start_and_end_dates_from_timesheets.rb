class RemoveStartAndEndDatesFromTimesheets < ActiveRecord::Migration[7.1]
  def change
    remove_column :timesheets, :start_date, :datetime
    remove_column :timesheets, :end_date, :datetime
  end
end
