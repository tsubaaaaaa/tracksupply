require "test_helper"

class PublicIndividualsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_individuals_show_url
    assert_response :success
  end
end
