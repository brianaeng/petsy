require 'test_helper'

class OrderProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Example valid order_products are valid" do
      order_products(:valid_order_product).valid?
      assert order_products(:valid_order_product).valid?
  end

  test "Order products must have an order_id" do
      order_products(:no_order_id).invalid?
      assert order_products(:no_order_id).invalid?
  end

  test "Order products must have a product_id" do
      order_products(:no_product_id).invalid?
      assert order_products(:no_product_id).invalid?
  end

  test "Order products should not have a quantity less than 1" do
      order_products(:quantity_too_small).invalid?
      assert order_products(:quantity_too_small).invalid?
  end
end
