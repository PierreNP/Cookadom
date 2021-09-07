class CreateTagDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_dishes do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :dish, index: true

      t.timestamps
    end
  end
end
