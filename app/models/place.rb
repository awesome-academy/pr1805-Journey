class Place < ApplicationRecord
  has_many :posts
  validates :name , presence: true, uniqueness: true
  enum status: [ :active, :archived ]
end
