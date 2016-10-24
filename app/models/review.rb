class Review < ActiveRecord::Base
  belongs_to :product
  validates :title, presence: true
  validates :description, presence: true
  validates :rating, numericality: { only_integer: true }
  #The below validation will pop up already due to rails form notifications.
  #validates_inclusion_of :rating, :within => [1,2,3,4,5], :message => "{{value}} is not a valid rating"

end
