class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :name
      t.integer :street_number
      t.string :street_type
      t.string :street_name
      t.string :additional_info 
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
