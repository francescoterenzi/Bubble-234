class Cocktail < ApplicationRecord
  validates :user_id, :presence => true
  validates :name, presence: true, uniqueness: :true
  validates :description, presence: true
  #validates_associated :user

  has_many :reviews
  belongs_to :user

  has_many :favorite_cocktails
  has_many :favorited_by, through: :favorite_cocktails, source: :user

  has_one :video

  mount_uploader :image , ImageUploader , presence: true
end
