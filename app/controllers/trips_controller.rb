class TripsController < ApplicationController
  before_action :set_trip, only: [:show]

  def index
    destination = params[:to]
    origin = params[:from]
    @trips = policy_scope(Trip)
    @trips = @trips.where(end_point: destination) if destination
    @trips = @trips.where(start_point: origin) if origin
    # create coordinates for start
    @start_markers = @trips.map do |trip|
      {
        lat: trip.start_lat,
        lng: trip.start_lng
      }
    end
    # create coordinates for end
    # @end_markers = @trips.map do |trip|
    # {
    #   lat: trip.end_lat,
    #   lng: trip.end_lng
    # }
    # end
  end

  def show
    @booking = Booking.new
    @booking.trip = @trip
  end

  def new
    @trip = Trip.new
    authorize @trip
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
    params.require(:trip).permit(:description, :seats_available, :start_point, :end_point, :start_time, :end_time, :price)
  end

  def set_trip
    @trip = Trip.find(params[:id])
    @bookings = Booking.where(trip_id: params[:id])
    authorize @trip
  end
end
