class BookingsController < ApplicationController
  before_action :set_booking, only: [:destroy, :update]
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
    @booking.update(booking_params)
    redirect_to trip_path(trip)
  end

  def destroy
    # record.user == current_user
    @booking.delete
    redirect_to trip_path(@booking.trip)
  end

  private

  def booking_params
    params.require(:booking).permit(:seats_number, :approved)
  end

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end
end
