class Trip < ApplicationRecord
  belongs_to :driver, class_name: "User"
  has_many :bookings
  has_many :users, through: :bookings, source: :passenger, foreign_key: :passenger_id
  has_many :reviews

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

  def users_other_than_(user)
    if user == driver
      users
    else
      users.where.not(id: user).to_a << driver
    end
  end
end
