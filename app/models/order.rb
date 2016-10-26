class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products
  accepts_nested_attributes_for :order_products, allow_destroy: true

  validates :buyer_id, presence: true
  validates_inclusion_of :status, :within => ["pending","paid","complete","cancelled"], :message => "{{value}} is not a valid status"
#If the order has been placed...
  validate :cc_4_digits
  validate :cc_not_expired
  validate :shipping_address
  validate :cant_buy_from_self

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
    order_products.each do | op |
      total += op.subtotal
    end
    return total
  end

  def cant_buy_from_self
    self.products.each do |product|
        if product.user_id == self.buyer_id
          errors.add(:buyer_id, "You are trying to buy a product that you sell.")
        end
      end
  end

  #status can only be complete if all of the order-products associated with that order have been shipped

end
