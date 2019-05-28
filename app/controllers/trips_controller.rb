class TripsController < ApplicationController
  before_action :set_trip, only: [:show]
  def show
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
    @booking = Booking.where(trip_id: params[:id])
    authorize @trip
  end
end
