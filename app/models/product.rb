class Product < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  has_many :product_categories
  has_many :categories, through: :product_categories#, foreign_key: :category_id
  accepts_nested_attributes_for :product_categories, :allow_destroy => true, :reject_if => :all_blank
  has_many :orders, through: :order_products

  validates :name, presence: true
  validates :user_id, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, presence: true

  validate :out_of_stock
  validate :picture_must_be_url

  def out_of_stock
    if self.quantity == 0 && self.active == true
      errors.add(:active, "Out of stock products should be inactive")
    end
  end

  def picture_must_be_url
    allowed_extensions = %w[.jpg .jpeg .png]
    if self.picture != nil && !allowed_extensions.any?{ |ext| self.picture.end_with?(ext) }
      errors.add(:picture, "Must be url for an image")
    end
  end

end
