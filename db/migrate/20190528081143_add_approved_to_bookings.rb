class AddApprovedToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :approved, :boolean, default: false
  end
end
