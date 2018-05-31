class Ingredient < ApplicationRecord
  belongs_to :parent_list, polymorphic: true
  validates :name, presence: true, length: { maximum: 250 }
  validates :quantity, length: { maximum: 250 }
end
