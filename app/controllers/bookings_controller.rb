class BookingsController < ApplicationController
  def create
    @trip = Trip.find(params[:trip_id])
    authorize @trip
    @booking = Booking.new(booking_params)
    authorize @booking
    @booking.passenger = current_user
    @booking.trip = @trip
    if @booking.save
      redirect_to trip_path(@trip)
    else
      render "trips/show"
    end
  end

  def booking_params
    params.require(:booking).permit(:approved)
  end
end
