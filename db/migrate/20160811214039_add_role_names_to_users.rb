class AddRoleNamesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :integer
    add_column :users, :name, :string, default: ""
  end
end
