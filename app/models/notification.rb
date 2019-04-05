class Notification < ApplicationRecord
  belongs_to :send_from, class_name: User.name
  belongs_to :send_to, class_name: User.name

  scope :newest , -> {order  created_at: :desc}
  scope :check_send_to , -> (user){where("send_to_id = #{user}")}
  scope :check_send_from, -> (user){where("send_from_id  != #{user}")}
end
