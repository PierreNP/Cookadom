class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.string :ingredients
      t.belongs_to :cook, index: true

      t.timestamps
    end
  end
end
