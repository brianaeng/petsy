class Order < ActiveRecord::Base
  belongs_to :user
  has_many :products, through: :order_products

  validates :address, :buyer_id, :cc_expiration, presence: true
  validates_inclusion_of :status, :within => ["pending","paid","complete","cancelled"], :message => "{{value}} is not a valid status"
  validates :cc_number, length: { is: 4 }

  validate :not_expired
  # validate :dif_buyer_user

  def not_expired
    if self.cc_expiration != nil && self.cc_expiration < Date.today
      errors.add(:cc_expiration, "That credit card is expired.")
    end
  end

  # def dif_buyer_user
  #   errors.add(:buyer_id, "buyer_id can't be the same as user_id") if buyer_id == user_id
  # end

end
