class ChangeColumnToEnrolments < ActiveRecord::Migration[6.1]
  def change
    rename_column :enrolments, :user_id, :student_id
  end
end
