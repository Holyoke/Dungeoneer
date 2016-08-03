class CreateAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :areas do |t|
      t.string :name, null: false
      t.belongs_to :project, foreign_key: true
      t.string :floor_plan
      t.string :thumbnail

      t.timestamps
    end
  end
end
