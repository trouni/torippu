require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get trips_show_url
    assert_response :success
  end

end
