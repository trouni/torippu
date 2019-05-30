class ReviewsController < ApplicationController
  def create
    @trip = Trip.find(params[:trip_id])
    @review = Review.new(review_params)
    @review.trip = @trip
    if @review.save
      redirect_to trip_path(@trip)
    else
      @booking = Booking.new
      render "trips/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end

