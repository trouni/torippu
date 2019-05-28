class TripsController < ApplicationController
  before_action :set_trip, only: [:show]

  def index
    if params[:destination].present?
      @trips = Trip.where(end_point: params[:destination])
    else
      @trips = Trip.all
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
