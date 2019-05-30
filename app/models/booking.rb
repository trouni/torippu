class Booking < ApplicationRecord
  belongs_to :passenger, class_name: "User"
  belongs_to :trip

  def validate(booking)
    if booking.seats_number < 1 ||
       booking.seats_number > trip.seats_remain ||
       booking.seats_number > trip.seats_available
      booking.errors[:seats_number] << 'shoupd be between 1 and seats_available'
    end
  end
end
