class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :photo, PhotoUploader

  has_many :bookings, foreign_key: :passenger_id
  has_many :trips_as_passenger, through: :bookings, source: :trip
  has_many :trips_as_driver, foreign_key: :driver_id, class_name: 'Trip'
  has_many :reviews, foreign_key: :reviewee_id, class_name: 'Review'

  def trips
    # Trip.joins(:bookings).where(passenger_id: id).or(Trip.where(driver_id: id))
    # trips_as_passenger + trips_as_driver
    Trip.joins(:bookings).where("bookings.passenger_id = #{id}").or(Trip.joins(:bookings).where(driver_id: id))
  end

  def rating
    reviews = Review.where("reviews.reviewee_id = #{id}")
    sum = 0
    if reviews.length.zero?
      return nil
    else
      reviews.each do |review|
        sum += review.rating
      end
    end
    return sum / reviews.length
  end
end
