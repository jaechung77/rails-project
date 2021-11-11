class CreateTimetables < ActiveRecord::Migration[6.1]
  def change
    create_table :timetables do |t|
      t.integer :subject_id
      t.string :day
      t.integer :start_time
      t.integer :end_time

      t.timestamps
    end
  end
end
