class Product < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  has_many :product_categories
  has_many :categories, through: :product_categories#, foreign_key: :category_id
  accepts_nested_attributes_for :categories, reject_if: :all_blank#reject_if: proc { |attributes| deep_blank?(attributes)} #, :allow_destroy => true

  # validates_associated :categories

  has_many :orders, through: :order_products
  validates :name, presence: true
  #validates :user_id, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, presence: true

  # def self.deep_blank?(hash)
  #   hash.each do |key, value|
  #     next if key == '_destroy'
  #     any_blank = value.is_a?(Hash) ? deep_blank?(value) : value.blank?
  #     return false unless any_blank
  #   end
  #   true
  # end

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      self.categories << category
    end
  end

end
