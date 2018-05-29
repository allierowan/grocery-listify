class Ingredient < ApplicationRecord
  belongs_to :recipe, optional: true
  belongs_to :grocery_list, optional: true
  validates :name, presence: true, length: { maximum: 250 }
  validates :quantity, length: { maximum: 250 }
end
