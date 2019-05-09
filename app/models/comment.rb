class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true
  has_many :notification, class_name: Notification.name, foreign_key: :comment_id, dependent: :destroy
end
