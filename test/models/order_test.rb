require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test "Order with minimal information is valid" do
    assert orders(:valid_order).valid?
  end

  test "Paid orders must have a cc_number" do
    assert orders(:no_cc_number).invalid?
  end

  test "Paid orders must have a cc_expiration" do
    assert orders(:no_cc_expiration).invalid?
  end

  test "Paid orders must have a shipping address" do
    assert orders(:no_address).invalid?
  end

  test "Order without a status is not valid" do
    assert orders(:no_status).invalid?
  end

  test "Order without a buyer_id is not valid" do
    assert orders(:no_buyer_id).invalid?
  end

  test "Order status can only be paid, pending, complete or cancelled" do
    assert orders(:invalid_status).invalid?
    assert orders(:pending_order).valid?
    #previously tested valid_status has a status of "paid"
    assert orders(:complete_order).valid?
    assert orders(:cancelled_order).valid?
  end

  test "Paid order cc_number must be 4 digits" do
    assert orders(:cc_number_too_short).invalid?
    assert orders(:cc_number_too_long).invalid?
  end

  test "CC_number must be a number" do
    assert orders(:cc_number_not_number).invalid?
  end

  test "Paid order cc_expiration must not be in the past" do
    assert orders(:cc_expired).invalid?
  end

  test "Buyer and the seller can't be the same user" do
    assert orders(:same_buyer_user).invalid?
  end

  test "An order where all products have shipped should have a complete status" do
    assert orders(:all_products_shipped_complete).valid?
    assert orders(:all_products_shipped_pending).invalid?
  end
end
