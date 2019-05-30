class AddCoordinatesToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :start_lat, :float
    add_column :trips, :start_lng, :float
    add_column :trips, :end_lat, :float
    add_column :trips, :end_lng, :float
  end
end
