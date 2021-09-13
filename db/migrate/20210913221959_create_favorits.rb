class CreateFavorits < ActiveRecord::Migration[5.2]
  def change
    create_table :favorits do |t|
      t.references :favorit_user, index: true
      t.references :favorit_dish, index: true

      t.timestamps
    end
  end
end
