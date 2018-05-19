class Review < ActiveRecord::Base
    
    belongs_to :cocktail
    belongs_to :user

    has_many :likes
    has_many :liked_by, through: :likes, source: :user 

    validates_associated :cocktail
end