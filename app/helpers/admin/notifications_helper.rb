module Admin::NotificationsHelper
  def check_notification notification
    if notification.opened_at == nil
      if (notification.send_from_type == "Followed") or (notification.send_from_type == "UnFollowed")
        return (link_to notification.send_to_type, admin_user_path(notification.send_to_id, notification_id: notification.id)) + " of "
      elsif (notification.send_from_type == "Reported") and (notification.send_to_type == "Account")
        return (link_to notification.send_to_type, admin_user_path(notification.send_to_id, notification_id: notification.id)) + " of "
      else
        return (link_to notification.send_to_type, admin_post_path(notification.post_id, notification_id: notification.id)) + " of "
      end
    else
      if (notification.send_from_type == "Followed") or (notification.send_from_type == "UnFollowed")
        return (link_to notification.send_to_type, admin_user_path(notification.send_to_id, notification_id: notification.id)) + " of "
      elsif (notification.send_from_type == "Reported") and (notification.send_to_type == "Account")
        return (link_to notification.send_to_type, admin_user_path(notification.send_to_id, notification_id: notification.id)) + " of "
      else
        return (link_to notification.send_to_type, admin_post_path(notification.post_id, notification_id: notification.id)) +" of "
      end
    end
  end
end
