require 'faker'

CITIES = [
  'Tokyo, 東京都, Japan',
  'Osaka, 大阪府, Japan',
  'Fukuoka, 福岡県, Japan',
  'Kyōto, 京都府, Japan'
]

USERS = [
  {
    username: "trouni",
    email: "trouni@me.com",
    photo: "https://avatars3.githubusercontent.com/u/34345789?v=4",
    password: "secret",
  },
  {
    username: "saad",
    email: "saad@le.com",
    photo: "https://avatars0.githubusercontent.com/u/21337523?v=4",
    password: "secret",
  },
  {
    username: "eugene",
    email: "eugene@le.com",
    photo: "https://avatars1.githubusercontent.com/u/49116295?v=4",
    password: "secret",
  },
  {
    username: "alex",
    email: "alex@le.com",
    photo: "https://avatars0.githubusercontent.com/u/48198772?v=4",
    password: "secret",
  },
]
puts 'Deleting bookings...'
Booking.destroy_all
puts 'Deleting trips...'
Trip.destroy_all
puts 'Deleting users...'
User.destroy_all
# puts 'deleting reviews'
# Review.destroy_all

puts 'Creating users and trips...'
USERS.each do |user_hash|
  user = User.create!(user_hash)
  user.remote_photo_url = user_hash[:photo]
  user.save!

  rand(2..10).times do
    start_time = DateTime.now + rand(1..30) + rand # start date between now and 1 month from now
    end_time = start_time + rand(1..18) / 24.0 # trip duration between 1 and 18 hours
    Trip.create!(
      start_time: start_time,
      end_time: end_time,
      start_point: CITIES.sample,
      end_point: CITIES.sample,
      description: Faker::TvShows::HowIMetYourMother.quote,
      seats_available: rand(1..3),
      driver: user,
      price: rand(1..10) * 500
    )
  end

  #   4.times do
  #   Review.create!(
  #     rating: rand(1..3),
  #     comment: Faker::Hipster.words(4),
  #     reviewed: user,
  #     )
  # end
end

puts 'Creating bookings...'
Trip.all.each do |trip|
  rand(1..trip.seats_available).times do |variable|
    Booking.create!(
      passenger: User.where.not(id: trip.driver.id).sample,
      trip: trip
    )
  end
end
