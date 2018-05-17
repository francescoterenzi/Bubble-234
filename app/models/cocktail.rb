class Cocktail < ApplicationRecord
  validates :user_id, :presence => true
  validates :name, presence: true, uniqueness: :true
  validates :description, presence: true
  #validates_associated :user

  has_many :reviews
  belongs_to :user
  mount_uploader :image , ImageUploader , presence: true
end
