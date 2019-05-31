class TripsController < ApplicationController
  before_action :set_trip, only: [:show]

  def index
    @trips = policy_scope(Trip)
    filter_by_date(params[:date])
    filter_by_journey(origin: params[:from], destination: params[:to])
    @markers = @trips.map do |trip|
      {
        lat: trip.start_lat,
        lng: trip.start_lng,
        infoWindow: render_to_string(partial: "infowindow", locals: { trip: trip }),
        image_url: helpers.asset_url('/app/assets/images/logo.jpeg')
      }
    end
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

  def filter_by_date(date = '')
    if date.present?
      date_time = DateTime.parse(date)
      @trips = @trips.where('start_time >= ? AND start_time < ?', date_time, date_time + 3)
    end
  end

  def filter_by_journey(destination: '', origin: '')
    if origin.present? && destination.present?
      # @trips = @trips.near(destination, 30, latitude: :end_lat, longitude: :end_lng).near(origin, 30, latitude: :start_lat, longitude: :start_lng)
      @trips = @trips.near(destination, 30, latitude: :end_lat, longitude: :end_lng) & @trips.near(origin, 30, latitude: :start_lat, longitude: :start_lng)
    elsif origin.present? || destination.present?
      @trips = @trips.near(destination, 30, latitude: :end_lat, longitude: :end_lng) + @trips.near(origin, 30, latitude: :start_lat, longitude: :start_lng)
    end
  end

  def trip_params
    params.require(:trip).permit(:description, :seats_available, :start_point, :end_point, :start_time, :end_time, :price)
  end

  def set_trip
    @trip = Trip.find(params[:id])
    @bookings = Booking.where(trip_id: params[:id])
    authorize @trip
  end
end
