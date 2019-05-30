class RemoveEndDateFromTrips < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips, :end_date, :date
  end
end
