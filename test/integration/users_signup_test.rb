require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  
  test "should get signup path" do
    get signup_path
    assert_response :success
  end
  
  test "reject an invalid signup" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: { username: " ", email: " ", password: "password ",
                                password_confirmation: " " } }
    end
    assert_template 'users/new'#Shows signup form again
    assert_select 'h2.panel-title'#Calls error messages partial: _errors.html.erb
    assert_select 'div.panel-body'#Calls the panel html for error messages also in _errors.html.erb
  end
  
  test "accept a vaild signup" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "Spencer ", email: "spencer@example.com ", password: "password ",
                                password_confirmation: "password" } }
    end
    follow_redirect!#Redirects user on successful signup
    assert_select 'users/show'#Goes to user's profile page - users/show.html.erb
    assert_not flash.empty?#Assert that the 'success' flash message appears.
  end
end