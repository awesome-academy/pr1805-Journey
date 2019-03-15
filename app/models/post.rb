class Post < ApplicationRecord
  has_many :rates
  has_many :comments
  has_many :reports
  belongs_to :user
  belongs_to :place
end
