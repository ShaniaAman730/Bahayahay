module NotificationsHelper
  def notify_user(user, message, notifiable = nil)
    notification = Notification.create!(user:, message:, notifiable:)

    ActionCable.server.broadcast(
      "notifications_#{user.id}",
      {
        type: "notification",
        message: message,
        id: notification.id,
        url: Rails.application.routes.url_helpers.notification_path(notification)
      }
    )
  end
end

