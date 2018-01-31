require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Sports")
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)#Logs in an admin user for the tests below.
  end
  
  test "should get categories index" do
    get categories_path#'get' is the http verb & 'categories_path' is the path found in rails routes.
    assert_response :success
  end
  
  test "should get new" do
    sign_in_as(@user, "password")#This syntax differs from that of Rails 4. Rails 5 cannot alter the sessions hash from a test.
    get new_category_path#'get' is the http verb & 'new_categories_path' is the path found in rails routes.
    assert_response :success
  end
  
  test "should get show" do
    get category_path(@category)#'get' is the http verb & 'categories_path(@category)' is the path with the @category instance argument found in rails routes.
    assert_response :success
  end
  
   test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: "sports" } }#This is the new syntax for Rails 5 to create (post) a new category.
    end
    assert_redirected_to categories_path
  end
end