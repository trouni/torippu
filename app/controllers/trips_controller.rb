class TripsController < ApplicationController
  before_action :set_trip, only: [:show]

  def index
    destination = params[:to]
    origin = params[:from]
    date = params[:date]
    @trips = policy_scope(Trip)
    @trips = @trips.where(end_point: destination) if destination
    @trips = @trips.where(start_point: origin) if origin
    @trips = @trips.where(start_date: date) if date
  end

  def show
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
    @bookings = Booking.where(trip_id: params[:id])
    authorize @trip
  end
end
