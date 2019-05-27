require 'faker'
puts 'deleting boockings'
# Bocking.destroy_all
puts 'deleting trips'
# Trip.destroy_all
puts 'deleting reviews'
# Review.destroy_all
puts 'creating ingredients...'

5.times do
  user = User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.email,
    password: 'secret',
    )
  2.times do
    trip_in_days = rand(1..5)
    Trip.create!(
      start_date: Date.today + trip_in_days,
      end_date: Date.today + trip_in_days,
      start_point: Faker::Address.city,
      end_point: Faker::Address.city,
      description: 'blabla-trip',
      seats_available: rand(1..3),
      user: user,
      )
  end
    4.times do
    Review.new(
      rating: rand(1..3),
      comment: Faker::Hipster.words(4),
      reviewed:
      )
  end
end
