class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: :true, uniqueness: :true
  validate :validate_username

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :cocktails, dependent: :destroy
  has_many :reviews

  #has_many :favorite_cocktails
  #has_many :favorites, through: :favorite_cocktails, source: :cocktail

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
    end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
end
