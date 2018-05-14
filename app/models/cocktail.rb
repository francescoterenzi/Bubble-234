class Cocktail < ApplicationRecord
  validates :name, presence: true, uniqueness: :true
  validates :description, presence: true
  validates :creation_date, presence: true
end
