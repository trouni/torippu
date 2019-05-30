class Trip < ApplicationRecord
  belongs_to :driver, class_name: "User"
  has_many :bookings

  geocoded_by :start_point, latitude: :start_lat, longitude: :start_lng
  # after_validation :geocode, if: :will_save_change_to_start_point?
  geocoded_by :end_point, latitude: :end_lat, longitude: :end_lng
  # after_validation :geocode, if: :will_save_change_to_end_point?
  after_validation :geocode_endpoints
  
  def start_date
    start_time.to_date
  end

  def end_date
    end_time.to_date
  end
  
  def booking?(user)
    bookings.each do |booking|
      return true if booking.passenger == user
    end
    return false
  end

  def approved_passenger?(user)
    bookings.each do |booking|
      return true if booking?(user) && booking.approved
    end
    return false
  end

  private

  def geocode_endpoints
    if end_point_changed?
      geocoded = Geocoder.search(end_point).first
      if geocoded
        self.end_lat = geocoded.latitude
        self.end_lng = geocoded.longitude
      end
    end
    if start_point_changed?
      geocoded = Geocoder.search(start_point).first
      if geocoded
        self.start_lat = geocoded.latitude
        self.start_lng = geocoded.longitude
      end
    end
  end
end
