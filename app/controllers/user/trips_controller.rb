class User::TripsController < ApplicationController
  def index
    # @trips = TripPolicy::User.new(current_user, User).resolve
    @trips = policy_scope(Trip, policy_scope_class: TripPolicy::User)
    render 'trips/index'
  end
end
