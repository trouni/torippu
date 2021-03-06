class User::TripsController < ApplicationController
  def index
    # @trips = TripPolicy::User.new(current_user, User).resolve
    @trips = policy_scope(Trip, policy_scope_class: TripPolicy::User)
    @upcoming_trips = @trips.where("start_time >= '#{DateTime.now}'")
    @past_trips = @trips.where("start_time < '#{DateTime.now}'")
  end

#   def rating
#     @passenger_rating = 0
#     @driver_rating = 0
#   end
end
