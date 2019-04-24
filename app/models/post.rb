class Post < ApplicationRecord
  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reports
  belongs_to :user
  belongs_to :place
  scope :newest , -> {order  created_at: :desc}
  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true
  validates :place,  presence: true
  before_save {self.title = title.upcase}

  scope :search_title, -> (title) {where("(title) LIKE '%#{title}%'")}
  scope :search_place, -> (place_id) {where(place_id: place_id)}
end
