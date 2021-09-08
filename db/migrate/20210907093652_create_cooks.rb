class CreateCooks < ActiveRecord::Migration[5.2]
  def change
    create_table :cooks do |t|

      t.belongs_to :user, index: true
      t.string :siren
      t.string :business_name
      t.string :legal_status
      t.string :headquarter
      t.string :vat_number
      t.string :commercial_register
      t.boolean :status, default: false
      
      t.timestamps
    end
  end
end
