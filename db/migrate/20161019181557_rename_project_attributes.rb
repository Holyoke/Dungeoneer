class RenameProjectAttributes < ActiveRecord::Migration[5.0]
  def change
    rename_column :areas, :project_id, :map_id
    rename_column :invites, :project_id, :map_id
    rename_table :project_memberships, :map_memberships
    rename_column :map_memberships, :project_id, :map_id
  end
end
