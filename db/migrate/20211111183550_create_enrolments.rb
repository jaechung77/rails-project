class CreateEnrolments < ActiveRecord::Migration[6.1]
  def change
    create_table :enrolments do |t|
      t.integer :user_id
      t.integer :teaching_id
      t.timestamps
    end
  end
end

