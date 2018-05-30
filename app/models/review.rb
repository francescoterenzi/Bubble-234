class Review < ActiveRecord::Base

    belongs_to :cocktail
    belongs_to :user

    has_many :likes, dependent: :destroy
    has_many :liked_by, through: :likes, source: :user, dependent: :destroy

    validates_associated :cocktail
    
    validates :rate, presence: true, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 5}
end
