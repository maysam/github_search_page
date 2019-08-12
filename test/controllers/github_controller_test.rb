require 'test_helper'

class GithubControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get root_url
    assert_response :success
  end

end
