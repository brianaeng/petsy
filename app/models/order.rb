class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products
  accepts_nested_attributes_for :order_products, allow_destroy: true

  validates :buyer_id, presence: true
  validates_inclusion_of :status, :within => ["pending","paid","complete","cancelled"], :message => "{{value}} is not a valid status"
  # validates :cc_number, length: { is: 4 }
  # validate :not_expired

  def not_expired
    if self.cc_expiration != nil && self.cc_expiration < Date.today
      errors.add(:cc_expiration, "That credit card is expired.")
    end
  end

  def cart_total
    total = 0
    order_products.each do | op |
      total += op.subtotal
    end
    return total
  end

  #status can only be complete if all of the order-products associated with that order have been shipped

end
