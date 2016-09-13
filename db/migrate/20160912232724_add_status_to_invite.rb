class AddStatusToInvite < ActiveRecord::Migration[5.0]
  def change
    add_column :invites, :accepted, :boolean, default: false, index: true
  end
end
