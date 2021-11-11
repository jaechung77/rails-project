class CreateTeachings < ActiveRecord::Migration[6.1]
  def change
    create_table :teachings do |t|
      t.integer :subject_id
      t.integer :teacher_id

      t.timestamps
    end
  end
end
