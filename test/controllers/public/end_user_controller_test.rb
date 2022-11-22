require "test_helper"

class Public::EndUserControllerTest < ActionDispatch::IntegrationTest
  test "should get worked" do
    get public_end_user_worked_url
    assert_response :success
  end
end
