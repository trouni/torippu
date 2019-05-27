class User < ApplicationRecord
  has_many :trips_as_driver, source: :trips, foreign_key: :driver_id
  has_many :trips_as_passenger, through: :bookings, foreign_key: :passenger_id
  has_many :reviews, foreign_key: :reviewed_id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :photo, PhotoUploader
end
