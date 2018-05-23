class Ingredient < ApplicationRecord
  belongs_to :recipe
  validates :name, presence: true, length: { maximum: 250 }
  validates :quantity, length: { maximum: 250 }
end
