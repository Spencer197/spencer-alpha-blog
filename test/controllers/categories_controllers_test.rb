require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Sports")
  end
  
  test "should get categories index" do
    get categories_path#'get' is the http verb & 'categories_path' is the path found in rails routes.
    assert_response :success
  end
  
  test "should get new" do
    get new_category_path#'get' is the http verb & 'new_categories_path' is the path found in rails routes.
    assert_response :success
  end
  
  test "should get show" do
    get category_path(@category)#'get' is the http verb & 'categories_path(@category)' is the path with the @category instance argument found in rails routes.
    assert_response :success
  end    
end