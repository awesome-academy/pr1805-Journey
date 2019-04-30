module NotificationsHelper
  def check_notifications notification
    if notification.opened_at == nil
      if (notification.send_from_type == "Followed") or (notification.send_from_type == "UnFollowed")
        return (link_to notification.send_to_type, user_path(notification.send_to_id, notification_id: notification.id))
      elsif (notification.send_from_type == "Reported") and (notification.send_to_type == "Account")
        return (link_to notification.send_to_type, user_path(notification.send_to_id, notification_id: notification.id))
      else
        return (link_to notification.send_to_type, post_path(notification.post_id, notification_id: notification.id))
      end
    else
      if (notification.send_from_type == "Followed") or (notification.send_from_type == "UnFollowed")
        return (link_to notification.send_to_type, user_path(notification.send_to_id, notification_id: notification.id))
      elsif (notification.send_from_type == "Reported") and (notification.send_to_type == "Account")
        return (link_to notification.send_to_type, user_path(notification.send_to_id, notification_id: notification.id))
      else
        return (link_to notification.send_to_type, post_path(notification.post_id, notification_id: notification.id))
      end
    end
  end
end
