class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @trip = Trip.find(params[:trip_id])
    @review.trip = @trip
    authorize @review
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @review = Review.new(review_params)
    @review.trip = @trip
    @review.reviewer = current_user
    authorize @review
    if @review.save
      redirect_to new_trip_review_path(@trip)
    else
      @booking = Booking.new
      render "reviews/new"
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :reviewee_id)
  end
end
