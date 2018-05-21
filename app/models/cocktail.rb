class Cocktail < ApplicationRecord
  validates :user_id, :presence => true
  validates :name, presence: true
  validates :description, presence: true
  validates_associated :user

  has_many :reviews, dependent: :destroy
  belongs_to :user

  has_many :favorite_cocktails, dependent: :destroy
  has_many :favorited_by, through: :favorite_cocktails, source: :user, dependent: :destroy

  has_one :video, dependent: :destroy

  mount_uploader :image , ImageUploader , presence: true, dependent: :destroy
end
