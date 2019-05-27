require 'faker'
EMAIL = %w(trouni@le.com saad@le.com eugene@le.com alex@le.com)
puts 'deleting boockings'
Booking.destroy_all
puts 'deleting trips'
Trip.destroy_all
puts 'deleting users'
User.destroy_all
puts 'deleting reviews'
# Review.destroy_all
puts 'deleting Review...'
i = 0
4.times do
  user = User.create!(

    email: EMAIL[i],
    password: 'secret',
    )
  i += 1
  2.times do
    trip_in_days = rand(1..5)
    Trip.create!(
      start_date: Date.today + trip_in_days,
      end_date: Date.today + trip_in_days,
      start_point: Faker::Address.city,
      end_point: Faker::Address.city,
      description: 'blabla-trip',
      seats_available: rand(1..3),
      driver: user,
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

Trip.all.each do |trip|
  Booking.create!(
    passenger: User.where.not(id: trip.driver.id).sample,
    trip: trip
    )
end
