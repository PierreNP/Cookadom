class RemoveColumnAvailabilityFromDishes < ActiveRecord::Migration[5.2]
  def change
    remove_column :dishes, :availability, :integer
  end
end
