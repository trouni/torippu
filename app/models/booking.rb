class Booking < ApplicationRecord
  belongs_to :passenger, class_name: "User"
  belongs_to :trip
  validates :seats_number, presence: true
  validates_numericality_of :seats_number, less_than: -> (trip) { trip.seats_available }
  validates_numericality_of :seats_number, greater_than: 0
end
