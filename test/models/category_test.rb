require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  def setup#Initiates the instance varialbe @catagory with the attribute of name: "sports". 
    @category = Category.new(name: "Sports")  
  end
  
  test "category should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?#If the name is not present (valid), the test will pass.
  end
  
  test "name should be unique" do
    @category.save
    @category2 = Category.new(name: "Sports")
    assert_not @category2.valid?#The name @category2 should return false since the name "sports" already exits.
  end
  
  test "name should not be too long" do
    @category.name = "a" * 26#The category name should not be more than 25 characters long.  26 will fail.
    assert_not @category.valid?
  end
  
  test "name should not be too short" do
    @category.name = "aa"#The category name should not be less than 3 characters long.  Two will fail.
    assert_not @category.valid?
  end
  
end