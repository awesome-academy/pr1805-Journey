class Place < ApplicationRecord
  has_many :posts
  validates :name , presence: true
  enum status: [ :active, :archived ]
end
