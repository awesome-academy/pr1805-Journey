class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :review, length: {maximum: 30}
  validates :star, presence: true
end
