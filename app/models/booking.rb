class Booking < ApplicationRecord
  belongs_to :passenger, class_name: "User"
  belongs_to :trip
  validates :seats_number, presence: true
end
