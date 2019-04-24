class Place < ApplicationRecord
  has_many :posts
  enum status: [ :active, :archived ]
  scope :newest, ->{order created_at: :desc}
  scope :search_place, ->(search_place){where("name like '%#{search_place}%'")}
  validates :name , presence: true, uniqueness: true
end
