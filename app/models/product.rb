class Product < ActiveRecord::Base # :nodoc:
  validates :name, presence: true, length: 2..40
  validates :description, presence: true, length: 5..140
  validates :price, presence: true
  validates :quantity, presence: true
end
