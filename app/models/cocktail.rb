class Cocktail < ApplicationRecord
  validates :user_id, :presence => true
  validates :name, presence: true, uniqueness: :true
  validates :description, presence: true
  validates :creation_date, presence: true
  #validates_associated :user

  belongs_to :user
end
