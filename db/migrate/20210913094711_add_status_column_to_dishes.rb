class AddStatusColumnToDishes < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes, :status, :integer, default: 0
  end
end
