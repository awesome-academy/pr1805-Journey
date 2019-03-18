class User < ApplicationRecord
  before_save {self.email = email.downcase}
  has_many :posts, dependent: :destroy
  has_many :active_relations, class_name: Relation.name,
  foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relations, class_name: Relation.name,
  foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relations , source: :followed
  has_many :followers ,through: :passive_relations, source: :follower
  has_many :rates
  has_many :comments
  has_many :reports

  validates :name , presence: true , length: {minimum: 5}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true , uniqueness: true,
  format: {with: VALID_EMAIL_REGEX}

  has_secure_password
  validates :password ,length: {minimum: 8 , maximum: 20}, allow_nil: true
  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
