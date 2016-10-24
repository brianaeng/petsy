class Product < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  has_many :product_categories
  has_many :categories, through: :product_categories
  accepts_nested_attributes_for :categories
  has_attached_file :image

  has_many :orders, through: :order_products

  validates :name, presence: true
  validates :user_id, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validate :out_of_stock
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  # validate :picture_must_be_url

  def categories_attributes(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.create(category_attribute)
      self.categories << category
    end
  end

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

  def average_rating
      reviews = self.reviews
      @ratings = []
      if reviews.length > 0
        reviews.each do |review|
          @ratings << review.rating.to_f
        end
        average_product_rating = @ratings.reduce(:+)/@ratings.length
        return average_product_rating.round
      end
  end
end
