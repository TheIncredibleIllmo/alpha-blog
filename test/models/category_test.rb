require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  #runs before any test
  def setup
    @category = Category.new(name: "Trival")
  end

  test "category should be valid" do
    #assetion
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = ""
    assert_not @category.valid?
  end

  test "name should be unique" do
    #it should be saved to validate uniqueness
    @category.save
    @second_category = Category.new(name: "News")
    assert_not @second_category.valid?
  end

  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end
end
