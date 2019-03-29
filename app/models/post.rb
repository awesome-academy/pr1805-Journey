class Post < ApplicationRecord
  has_many :rates
  has_many :comments
  has_many :reports
  belongs_to :user
  belongs_to :place
  scope :newest , -> {order  created_at: :desc}
  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true
  validates :place,  presence: true
  before_save {self.title = title.upcase}
end
