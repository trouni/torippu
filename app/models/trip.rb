class Trip < ApplicationRecord
  belongs_to :driver, class_name: "User"
  has_many :bookings

  def start_date
    start_time.to_date
  end

  def end_date
    end_date.to_date
  end

  def booking?(user)
    bookings.each do |booking|
      return true if booking.passenger == user

    end
    return false
  end

  def approved_passenger?(user)
    bookings.each do |booking|
      return true if booking?(user) && booking.approved

    end
    return false
  end
end
