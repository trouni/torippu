class BookingsController < ApplicationController
  def create
    @trip = Trip.find(params[:trip_id])
    @booking = Booking.new(booking_params)
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
