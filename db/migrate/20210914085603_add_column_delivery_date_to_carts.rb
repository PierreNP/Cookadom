class AddColumnDeliveryDateToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :delivery_date, :datetime
  end
end
