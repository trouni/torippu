require 'faker'
require 'yaml'

addresses = YAML.load_file('db/addresses.yml')

USERS = [
  {
    username: "trouni",
    email: "trouni@me.com",
    photo: "https://avatars3.githubusercontent.com/u/34345789?v=4",
    password: "secret",
  },
  {
    username: "saad",
    email: "saad@me.com",
    photo: "https://avatars0.githubusercontent.com/u/21337523?v=4",
    password: "secret",
  },
  {
    username: "eugene",
    email: "eugene@me.com",
    photo: "https://avatars1.githubusercontent.com/u/49116295?v=4",
    password: "secret",
  },
  {
    username: "alex",
    email: "alex@me.com",
    photo: "https://avatars0.githubusercontent.com/u/48198772?v=4",
    password: "secret",
  },
]

puts 'deleting reviews'
Review.destroy_all
puts 'Deleting bookings...'
Booking.destroy_all
puts 'Deleting trips...'
Trip.destroy_all
puts 'Deleting users...'
User.destroy_all


i = 0
100.times do
  name = Faker::Name.name.split(" ").first
  username = User.new(
    username: name,
    email: name + i.to_s + "@me.com",
    password: "secret")
  i += 1
  username.remote_photo_url = "http://lorempixel.com/200/200/people/"
  username.save!
  print "#"
  # create_trips(username)
end

puts ""
puts 'Creating users...'
USERS.each do |user_hash|
  user = User.create!(user_hash)
  user.remote_photo_url = user_hash[:photo]
  user.save!
  print "#"
  # create_trips(user)
end

puts "Creating trips..."
addresses["from"].each do |address|
  start_time = DateTime.now - rand(1..60) + rand(1..60) + rand # start date between now and 1 month from now
  end_time = start_time + rand(1..10) / 24.0 # trip duration between 1 and 10 hours
  Trip.create!(
    start_time: start_time,
    end_time: end_time,
    start_point: address,
    end_point: addresses["to"].sample,
    description: Faker::TvShows::HowIMetYourMother.quote,
    seats_available: rand(1..4),
    driver: User.all.sample,
    price: 1500 + rand(1..70) * 100
  )
  print "#"
end


puts 'Creating bookings...'
200.times do
  Trip.where('end_time < ?', Time.now).sample do |trip|
    rand(1..trip.seats_available).times do |variable|
      b = Booking.create!(
        passenger: User.where.not(id: trip.driver.id).sample,
        trip: trip,
        approved: (rand(3) >= 1)
      )
      r = Review.new(
        comment: Faker::TvShows::HowIMetYourMother.quote,
        rating: rand(3..5),
        trip: trip,
        reviewee: booking.passenger,
        reviewer: trip.driver
        )
      r.save!
    end
  end
  print "#"
end
