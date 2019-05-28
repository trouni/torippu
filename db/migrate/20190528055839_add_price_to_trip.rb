class AddPriceToTrip < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :price, :integer, default: 0
  end
end
