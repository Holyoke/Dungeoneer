class AddRoleColumnToInvites < ActiveRecord::Migration[5.0]
  def change
    add_column :invites, :role, :integer, default: 0, null: false
  end
end
