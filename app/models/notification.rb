class Notification < ApplicationRecord
  belongs_to :send_from, class_name: User.name
  belongs_to :send_to, class_name: User.name
  belongs_to :report, dependent: :destroy, optional: true
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  after_create_commit :perform

  scope :newest , -> {order  created_at: :desc}
  scope :check_send_to , -> (user){where send_to_id: user}
  scope :check_send_from, -> (user){where.not send_from_id: user}
  scope :admin_check_send_to_id, ->(current_admin){where send_to_id: current_admin.id}
  scope :admin_check_send_from_type, ->{where.not send_from_type: 'Reported'}
  scope :check_send_from_type, ->{where send_from_type: 'Reported'}
  scope :check_opened_at, ->{where opened_at: nil}

  def perform
    ActionCable.server.broadcast "notification_channel_#{self.send_to_id}",
      notification: ApplicationController.renderer.render(partial: 'notifications/notification', locals: { notification: self }),
      counter: ApplicationController.renderer.render(partial: "notifications/notification_count",
        locals: {new_notifications_count: Notification.admin_check_send_from_type
          .check_send_to(send_to_id).check_send_from(send_to_id)
          .check_opened_at})
  end

end
