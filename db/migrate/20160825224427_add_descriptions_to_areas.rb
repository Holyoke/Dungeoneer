class AddDescriptionsToAreas < ActiveRecord::Migration[5.0]
  def change
    add_column :areas, :description, :text
  end
end
