class AddDimensionsToFloorPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :areas, :width, :float
    add_column :areas, :height, :float
  end
end
