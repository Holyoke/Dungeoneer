class CreatePins < ActiveRecord::Migration[5.0]
  def change
    create_table :pins do |t|
      t.float :x
      t.float :y
      t.string :description
      t.belongs_to :area

      t.timestamps
    end
  end
end
