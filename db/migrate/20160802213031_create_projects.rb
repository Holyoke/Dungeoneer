class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :license
      t.timestamps
      t.belongs_to :owner, class_name: "User"
    end
  end
end
