class Review < ActiveRecord::Base

    belongs_to :cocktail
    belongs_to :user

    has_many :likes, dependent: :destroy
    has_many :liked_by, through: :likes, source: :user, dependent: :destroy

    validates_associated :cocktail
end
