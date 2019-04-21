class Report < ApplicationRecord
  belongs_to :user
  belongs_to :post
  scope :newest , -> {order  created_at: :desc}
end
