require 'test_helper'

class MatchResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get match_results_create_url
    assert_response :success
  end

  test "should get update" do
    get match_results_update_url
    assert_response :success
  end

end
