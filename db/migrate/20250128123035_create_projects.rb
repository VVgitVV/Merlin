class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :aim
      t.float :hourly_rate
      t.boolean :completed
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
