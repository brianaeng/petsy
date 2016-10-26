require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test "Order with minimal information is valid" do
    orders(:valid_order).valid?
    assert orders(:valid_order).valid?
  end

  test "Paid orders must have a cc_number" do
    orders(:no_cc_number).invalid?
    assert orders(:no_cc_number).invalid?
  end

  test "Paid orders must have a cc_expiration" do
    orders(:no_cc_expiration).invalid?
    assert orders(:no_cc_expiration).invalid?
  end

  test "Paid orders must have a shipping address" do
    orders(:no_address).invalid?
    assert orders(:no_address).invalid?
  end

  test "Order without a status is not valid" do
    orders(:no_status).invalid?
    assert orders(:no_status).invalid?
  end

  test "Order without a buyer_id is not valid" do
    orders(:no_buyer_id).invalid?
    assert orders(:no_buyer_id).invalid?
  end

  test "Order status can only be paid, pending, complete or cancelled" do
    orders(:invalid_status).invalid?
    assert orders(:invalid_status).invalid?
    orders(:pending_order).valid?
    assert orders(:pending_order).valid?
    #previously tested valid_status has a status of "paid"
    orders(:complete_order).valid?
    assert orders(:complete_order).valid?
    orders(:cancelled_order).valid?
    assert orders(:cancelled_order).valid?
  end

  test "Paid order cc_number must be 4 digits" do
    orders(:cc_number_too_short).invalid?
    assert orders(:cc_number_too_short).invalid?
    orders(:cc_number_too_long).invalid?
    assert orders(:cc_number_too_long).invalid?
  end

  test "CC_number must be a number" do
    assert orders(:cc_number_not_number).invalid?
  end

  test "Paid order cc_expiration must not be in the past" do
    orders(:cc_expired).invalid?
    assert orders(:cc_expired).invalid?
  end

  test "Buyer and the seller can't be the same user" do
    orders(:same_buyer_user).invalid?
    assert orders(:same_buyer_user).invalid?
  end
end
