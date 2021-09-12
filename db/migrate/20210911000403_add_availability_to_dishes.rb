class AddAvailabilityToDishes < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes, :availability, :boolean
  end
end
