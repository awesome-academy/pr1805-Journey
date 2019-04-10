class NotificationsController < ApplicationController
  def index
    if logged_in?
      @notifications = current_user.notifications
    end
  end
end
