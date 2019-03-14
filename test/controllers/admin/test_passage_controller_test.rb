require 'test_helper'

class Admin::TestPassageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_test_passage_index_url
    assert_response :success
  end

end
