class CreateTimestamps < ActiveRecord::Migration[7.1]
  def change
    create_table :timestamps do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.text :task_description
      t.references :timesheet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
