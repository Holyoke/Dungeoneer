class RenameProjectsToMaps < ActiveRecord::Migration[5.0]
  def change
    rename_table :projects, :maps
  end
end
