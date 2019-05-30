class User::TripsController < ApplicationController
  def index
    # @trips = TripPolicy::User.new(current_user, User).resolve
    @trips = policy_scope(Trip, policy_scope_class: TripPolicy::User)
    @upcoming_trips = @trips.where("#{start_time.strftime("%Y-%m-%d")} >= '#{Date.today.strftime("%Y-%m-%d")}'")
    @past_trips = @trips.where("#{start_time.strftime("%Y-%m-%d")} < '#{Date.today.strftime("%Y-%m-%d")}'")
  end
end
