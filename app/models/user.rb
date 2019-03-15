class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :active_relations, class_name: Relation.name,
  foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relations, class_name: Relation.name,
  foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relations , source: :followed
  has_many :followers ,through: :passive_relations, source: :follower
  has_many :rates
  has_many :comments
  has_many :reports
end
