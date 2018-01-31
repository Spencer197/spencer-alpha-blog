require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)#Logs in an admin user for the tests below.
  end
  
  test "get new category form and create category" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do#Tests that the category count differs by 1 after creating a new category.
      post categories_path, params: { category: { name: "Sports"} }#The http post request is sent to the categories_path & is directed to the create action to create the category "Sports".
      follow_redirect!
    end
    assert_template 'categories/index'#Test that user is sent to 'categories/index' view.
    assert_match "Sports", response.body#Tests that "Sports" appears on the page.
  end
  
  #This test was copied from the above test and edited to test for an invalid category entry.
  test "invalid form submission results in failure" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do#Note the alteration of this line from the above test.
      post categories_path, params: { category: { name: ""} }#An empty string is passed in.
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'#Checks for the title of the error message from the shared/_errors partial.
    assert_select 'div.panel-body'#Checks for the body of the error message from the shared/_errors partial.
  end

end