require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'a category name must be unique' do
    Category.create(name: "exotic")
    assert Category.create(name: "exotic").invalid?
    assert Category.create(name: "new category").valid?
  end
end
