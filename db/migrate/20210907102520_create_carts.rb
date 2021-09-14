class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.integer :status, default: 0
      t.string :stripe_customer_id
      t.belongs_to :user, index: true
      t.belongs_to :address, index:true, optional: true

      t.timestamps
    end
  end
end
