class Cocktail < ApplicationRecord
  
  validates :user_id, :presence => true
  validates :name, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates_associated :user

  has_many :reviews, dependent: :destroy
  belongs_to :user

  has_many :favorite_cocktails, dependent: :destroy
  has_many :favorited_by, through: :favorite_cocktails, source: :user, dependent: :destroy

  has_one :video, dependent: :destroy

  mount_uploader :image , ImageUploader, dependent: :destroy

  def media
    counter = 0
    sum = 0
    if self.reviews.size > 0
      self.reviews.each do |r|
        sum += r.rate
        counter += 1
      end
      (sum.to_f / counter).round(1)
    else
      sum
    end
  end
end
