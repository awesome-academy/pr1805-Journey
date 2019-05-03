class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :password_reset_token

  before_save { self.email = email.downcase }
  before_create :create_activation_digest
  scope :activated, -> { where activated: true }

  has_many :posts, dependent: :destroy
  has_many :active_relations, class_name: Relation.name,
  foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relations, class_name: Relation.name,
  foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relations , source: :followed
  has_many :followers ,through: :passive_relations, source: :follower
  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, class_name: Notification.name, foreign_key: :send_to_id, dependent: :destroy

  validates :name , presence: true , length: {minimum: 5}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true , uniqueness: true,
  format: {with: VALID_EMAIL_REGEX}

  has_secure_password
  validates :password ,length: {minimum: 8 , maximum: 20}, allow_nil: true
  validates :phone, uniqueness: true ,length: {minimum:8}, allow_nil: true
  validates :bio , length: {maximum: 150}, allow_nil: :true
  mount_uploader :picture, AvatarUploader
  validate :avatar_size
  scope :search_name_email,
    ->(search_name, search_email){where("name like '%#{search_name}%' or email like '%#{search_email}%'")}
  scope :newest, ->{order created_at: :desc}
  scope :search_user, -> (keyword) {where(" email LIKE '%#{keyword}%'
    OR name LIKE '%#{keyword}%'")}
  scope :group_by_type, -> (type) {
    case type
    when type = "week"
      group("DATE_FORMAT(activated_at,'%v-%x')").count
    when type = "month"
      group("DATE_FORMAT(activated_at,'%b-%x')").count
    when type = "year"
      group("DATE_FORMAT(activated_at,'%x')").count
    end
  }

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

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(:remember_token)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
    end

  def active
    update_columns activated: true ,activated_at: Time.zone.now
  end

  def block
    update blocked_at: Time.zone.now
  end

  def unblock
    update blocked_at: nil
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def follow other_user
    # following << other_user
    active_relations.create(followed_id: other_user.id)
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def create_password_reset_digest
    self.password_reset_token = User.new_token
    update_columns reset_digest: User.digest(password_reset_token)
    update_columns reset_send_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def check_expiration?
    reset_send_at < 2.hours.ago
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def avatar_size
    if (picture.size) > Settings.user.avatar_size.megabyte
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
