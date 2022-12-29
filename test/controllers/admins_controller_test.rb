require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get admins_top_url
    assert_response :success
  end

end
