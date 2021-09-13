class ChangeRateIntoValueInRatings < ActiveRecord::Migration[5.2]
  def change
    rename_column :ratings, :rate, :value
  end
end
