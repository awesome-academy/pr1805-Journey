class Place < ApplicationRecord
  has_many :posts
  validates :name , presence: true, uniqueness: true
  enum status: [ :active, :archived ]
  scope :newest, ->{order created_at: :desc}
  scope :check_status, ->{where status: :archived}
  scope :search_place, ->(search_place){where("name like '%#{search_place}%'")}
  scope :group_by_type, -> (type) {
    case type
    when type = "week"
      group("DATE_FORMAT(created_at,'%v-%x')").count
    when type = "month"
      group("DATE_FORMAT(created_at,'%b-%x')").count
    when type = "year"
      group("DATE_FORMAT(created_at,'%x')").count
    end
  }
end
