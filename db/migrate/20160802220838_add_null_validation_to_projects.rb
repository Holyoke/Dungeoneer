class AddNullValidationToProjects < ActiveRecord::Migration[5.0]
  def change
    change_column :projects, :name, :string, :null => false
  end
end
