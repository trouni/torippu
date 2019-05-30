class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :trips, through: :bookings
  has_many :ratings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  ???validates :trip, presence: true, uniqueness: true
  ??db:migrate after this?
end
