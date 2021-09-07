class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :comment
      t.belongs_to :sender, index: true
      t.belongs_to :recipient, index: true
   
      t.timestamps
    end
  end
end
