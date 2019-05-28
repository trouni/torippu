class AddTimeToTrip < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :start_time, :datetime
    add_column :trips, :end_time, :datetime
  end
end
