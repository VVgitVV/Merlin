class CreateTimesheets < ActiveRecord::Migration[7.1]
  def change
    create_table :timesheets do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
