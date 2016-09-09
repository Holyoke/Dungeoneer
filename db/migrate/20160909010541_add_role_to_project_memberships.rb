class AddRoleToProjectMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :project_memberships, :role, :integer, default: 0, null: false
  end
end
