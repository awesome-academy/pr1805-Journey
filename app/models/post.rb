class Post < ApplicationRecord
  has_many :rates
  has_many :comments
  has_many :reports
  belongs_to :user
  belongs_to :place
  scope :order_post , -> {order  created_at: :desc}
  validates :title, presence: true, length: {maximum: 100}
  validates :content, length: {maximum: 50}, presence: true
  validates :place,  presence: true
  before_save {self.title = title.upcase}
end
