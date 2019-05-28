class AddSeatsNumberToBookings < ActiveRecord::Migration[5.2]
  def change
    add column :bookings, :seats_number, :integer, default: 1
  end
end
