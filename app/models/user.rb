class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :first_name, presence: true
  # validates :last_name, presence: true
  validates :username, presence: :true, uniqueness: :true
  validate :validate_username

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :twitter]

  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :cocktails, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :reviews_liked, through: :likes, source: :review, dependent: :destroy

  has_many :favorite_cocktails, dependent: :destroy
  has_many :favorites, through: :favorite_cocktails, source: :cocktail, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

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

    # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      username = auth.info.name
      user.username = username.downcase.gsub(/\s+/, "")
      user.first_name, user.last_name = auth.info.name.split(' ', 2)
      default_image = "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg"
      if auth.info.image != default_image
        user.avatar = AvatarUploader.new
        user.avatar.download! auth.info.image
      end
    end
  end

  def self.from_omniauth_twitter(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email #"#{auth.info.nickname}@twitter.com"
      user.username = auth.info.nickname
      user.first_name, user.last_name = auth.info.name.split(' ', 2)
      default_image = "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"
      if auth.info.image != default_image
        user.avatar = AvatarUploader.new
        user.avatar.download! auth.info.image
      end
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def media
    counter = 0
    sum = 0
    if self.cocktails.size > 0
      self.cocktails.each do |c|
        sum += c.media
        counter += 1
      end
      (sum / counter).round(1)
    else
      sum
    end
  end

end
