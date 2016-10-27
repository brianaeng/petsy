class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products
  accepts_nested_attributes_for :order_products, allow_destroy: true

  validates :buyer_id, presence: true
  validates_inclusion_of :status, :within => ["pending","paid","complete","cancelled"], :message => "{{value}} is not a valid status"

  validate :cc_4_digits
  validate :cc_not_expired
  validate :shipping_address
  validate :cant_buy_from_self
  validates :cc_number, numericality: { only_integer: true }
  validate :complete_status

  def shipping_address
    if self.status == "paid" && self.address == nil
        errors.add(:address, "You must enter a shipping address.")
    end
  end

  def cc_not_expired
    if self.status == "paid"
      if self.cc_expiration == nil
        errors.add(:cc_expiration, "You must enter an expiration date for your credit card")
      elsif self.cc_expiration < Date.today
        errors.add(:cc_expiration, "That credit card is expired.")
      end
    end
  end

  def cc_4_digits
    if self.status == "paid"
      if self.cc_number == nil
        errors.add(:cc_expiration, "You must enter a credit card number")
      elsif self.cc_number.length != 4
        errors.add(:cc_expiration, "Only store four.")
      end
    end
  end

  def cart_total
    total = 0
    available_products.each do | op |
      total += op.subtotal
    end
    return total
  end

  def available_products
    ops = []
    order_products.each do | orderproduct |
      if orderproduct.product.active == true
        # If fewer products are available than when originally added to cart, only show the available number
        orderproduct.quantity = orderproduct.product.quantity if orderproduct.product.quantity < orderproduct.quantity
        ops << orderproduct
      end
    end
    return ops
  end

  def cant_buy_from_self
    self.products.each do |product|
        if product.user_id == self.buyer_id
          errors.add(:buyer_id, "You are trying to buy a product that you sell.")
        end
      end
  end

  def complete_status
    shipped_products = 0
    self.order_products.each do |op|
      if op.shipped == true
        shipped_products += 1
      end
    end

    if self.order_products.length != 0
      if self.order_products.length == shipped_products && self.status != "complete"
        errors.add(:status, "Orders where all items have shipped should be complete.")
      elsif self.order_products.length != shipped_products && self.status == "complete"
        errors.add(:status, "Orders can not be complete if there are un-shipped items.")
      end
    end
  end
end
