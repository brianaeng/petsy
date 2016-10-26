class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products
  accepts_nested_attributes_for :order_products, allow_destroy: true

  validates :buyer_id, presence: true
  validates_inclusion_of :status, :within => ["pending","paid","complete","cancelled"], :message => "{{value}} is not a valid status"
  validates :cc_4_digits
  validate :cc_not_expired

  def cc_not_expired
    if self.status == "paid"
      if self.cc_expiration != nil && self.cc_expiration < Date.today
        errors.add(:cc_expiration, "That credit card is expired.")
      end
    end
  end

  def cc_4_digits
    if self.status == "paid"
      if self.cc_number != nil && self.cc_number.length != 4
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

  #status can only be complete if all of the order-products associated with that order have been shipped

end
