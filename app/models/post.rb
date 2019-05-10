class Post < ApplicationRecord
  before_save {self.title = title.upcase}
  belongs_to :user
  belongs_to :place
  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, class_name: Notification.name, foreign_key: :post_id, dependent: :destroy

  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true
  validates :place,  presence: true
  enum status: [:active, :archived]
  mount_uploader :picture, AvatarUploader

  scope :newest , -> {order  created_at: :desc}
  scope :check_status, ->{where status: :archived}
  scope :search_title, ->(search_title){where("title like '%#{search_title}%'")}
  scope :search_place, ->(search_place){joins("inner join places on places.id = place_id and places.name like '%#{search_place}%'")}
  scope :search_content, ->(search_content){where("content like '%#{search_content}%'")}
  scope :search_title, -> (title) {where(" title LIKE '%#{title}%'")}
  scope :search_place, -> (place_id) {where(place_id: place_id)}
  scope :group_by_type, -> (type) {
    case type
    when type = "week"
      group("DATE_FORMAT(created_at,'%v-%x')").count
    when type = "month"
      group("DATE_FORMAT(created_at,'%b-%x')").count
    when type = "year"
      group("DATE_FORMAT(created_at,'%x')").count
    end
  }

  def rate
    rates.average(:star)&.round(2) || 0
  end
end
