class AddImageToSubjects < ActiveRecord::Migration[6.1]
  def change
    add_column :subjects, :image, :string
  end
end
