class Product < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  has_many :product_categories
  has_many :categories, through: :product_categories#, foreign_key: :category_id
  accepts_nested_attributes_for :categories
  has_many :orders, through: :order_products
  validates :name, presence: true
  #validates :user_id, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, presence: true

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      self.categories << category
    end
  end
end
