class Category < ActiveRecord::Base
  has_many :products, through: :product_categories, foreign_key: :product_id
  validates :name, presence: true
end
