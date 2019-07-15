class StatusChannel < ApplicationCable::Channel
  def subscribed
    current_user.update_attribute(:online, true)
    stream_from("status_channel")

    broadcast_online_users
  end

  def unsubscribed
    stop_all_streams
    current_user.update_attribute(:online, false)
    stream_from("status_channel")

    ActionCable.server.broadcast "status_channel",
                                 users: User.offline.as_json
  end

  private

  def broadcast_online_users
    ActionCable.server.broadcast "status_channel",
                                 users: User.online.as_json
  end
end
