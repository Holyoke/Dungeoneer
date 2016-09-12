class AddNullFalseValuesToFloorPlan < ActiveRecord::Migration[5.0]
  def change
    change_column :areas, :height, :float, null: false
    change_column :areas, :width, :float, null: false
  end
end
