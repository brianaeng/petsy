class Review < ActiveRecord::Base
  belongs_to :product
  validates :title, :description, presence: true
  validates :rating, numericality: { only_integer: true }
  validates_inclusion_of :rating, :within => [1,2,3,4,5], :message => "{{value}} is not a valid rating"

end
