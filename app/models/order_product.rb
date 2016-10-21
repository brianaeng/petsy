class OrderProduct < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :order_id, :product_id, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  # validate :product_must_be_in_stock

  #quantity can not exceed the quantity available for that product
  def product_must_be_in_stock
    if self.quantity > Product.where(id: :product_id).quantity
       errors.add(:quantity, "That request exceeds the number of instock products")
    end
  end

end
