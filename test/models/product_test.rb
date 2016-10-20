require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Product with minimal information is valid" do
    products(:valid_penguin).valid?
    assert products(:valid_penguin).valid?
    #photo url is optional when creating a new product
    products(:pictureless_animal).valid?
    assert products(:pictureless_animal).valid?
  end
end
