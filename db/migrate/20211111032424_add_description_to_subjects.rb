class AddDescriptionToSubjects < ActiveRecord::Migration[6.1]
  def change
    add_column :subjects, :description, :text
  end
end
