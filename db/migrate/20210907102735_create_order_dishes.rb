class CreateOrderDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :order_dishes do |t|
      t.integer :quantity
      t.belongs_to :cart, index: true
      t.belongs_to :dish, index: true

      t.timestamps
    end
  end
end
