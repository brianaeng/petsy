class Review < ActiveRecord::Base
  belongs_to :product
  validates :rating, :title, :description, presence: true

end
