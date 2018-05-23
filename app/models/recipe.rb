class Recipe < ApplicationRecord
  has_many :ingredients
  validates :name, presence: true, length: { maximum: 200 }
  validates :url, presence: true, length: { maximum: 1000 }
end
