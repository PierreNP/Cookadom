class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :address
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
