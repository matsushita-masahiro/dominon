require 'test_helper'

class MatchInningsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get match_innings_new_url
    assert_response :success
  end

  test "should get edit" do
    get match_innings_edit_url
    assert_response :success
  end

end
