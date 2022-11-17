require 'test_helper'

class MatchInningControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get match_inning_new_url
    assert_response :success
  end

  test "should get edit" do
    get match_inning_edit_url
    assert_response :success
  end

end
