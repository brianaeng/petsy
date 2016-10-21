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

  test "Product without a name is not valid" do
    products(:nameless_animal).invalid?
    assert products(:nameless_animal).invalid?
  end

  test "Product without a price is not valid" do
    products(:priceless_animal).invalid?
    assert products(:priceless_animal).invalid?
  end

  test "Product without a quantity is not valid" do
    products(:quantityless_animal).invalid?
    assert products(:quantityless_animal).invalid?
  end

  test "Product without a description is not valid" do
    products(:descriptionless_animal).invalid?
    assert products(:descriptionless_animal).invalid?
  end

  test "Product can be out-of-stock and inactive" do
    products(:out_of_stock_animal).valid?
    assert products(:out_of_stock_animal).valid?
  end

  test "Out-of-stock products should be inactive" do
    products(:active_out_of_stock_animal).invalid?
    assert products(:active_out_of_stock_animal).invalid?
  end

  test "Products can not be free" do
    products(:free_animal).invalid?
    assert products(:free_animal).invalid?
  end

  test "Products can NOT have a negative price" do
    products(:neg_price_animal).invalid?
    assert products(:neg_price_animal).invalid?
  end

  test "Products can NOT have a negative quantity" do
    products(:neg_quantity_animal).invalid?
    assert products(:neg_quantity_animal).invalid?
  end

  test "Products with pictures must have urls ending in .jpg, .jpeg or .png" do
    products(:picture_not_url_animal).invalid?
    assert products(:picture_not_url_animal).invalid?
  end

end
