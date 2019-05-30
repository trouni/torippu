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
    @booking = Booking.new
    @booking.trip = @trip
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.driver = current_user
    authorize @trip
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:description, :seats_available, :start_point, :end_point, :start_date, :end_date, :start_time, :end_time, :price)
  end

  def set_trip
    @trip = Trip.find(params[:id])
    @bookings = Booking.where(trip_id: params[:id])
    authorize @trip
  end
end
