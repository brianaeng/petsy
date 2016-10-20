class Category < ActiveRecord::Base
  has_many :product_categories
  has_many :products, through: :product_categories, foreign_key: :product_id
  accepts_nested_attributes_for :product_categories, :allow_destroy => true, :reject_if => :all_blank
  validates :name, presence: true
end
