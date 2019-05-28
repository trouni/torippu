class TripsController < ApplicationController
  before_action :set_trip, only: [:show]

  def index
    if params[:destination]
      destination = params[:destination]
      origin = params[:origin] || "Tokyo"
      date = params[:date]
      @trips = policy_scope(Trip).where(end_point: destination, start_point: origin)
    else
      @trips = policy_scope(Trip)
    end
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
