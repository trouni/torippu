class BookingsController < ApplicationController
  before_action :set_booking, only: [:update, :destroy]

  def create
    @trip = Trip.find(params[:trip_id])
    @booking = Booking.new(booking_params)
    @booking.passenger = current_user
    @booking.trip = @trip
    authorize @booking
    if @booking.save
      redirect_to trip_path(@trip)
    else
      render "trips/show"
    end
  end

  def update
    @trip = Trip.find(params[:trip_id])
    @booking.update(booking_params)
    redirect_to trip_path(@trip)
  end

  def destroy
    @booking.delete
    redirect_to trip_path(@booking.trip)
  end

  private

  def booking_params
    params.require(:booking).permit(:approved)
  end

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end
end
