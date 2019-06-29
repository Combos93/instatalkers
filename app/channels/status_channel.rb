class StatusChannel < ApplicationCable::Channel
  def subscribed
    current_user.update_attribute(:online, true)
    stream_from("status_channel")
    broadcast_online_users
  end

  def unsubscribed
    current_user.update(online: false)
    #broadcast_online_users
  end

  private

  def broadcast_online_users
    ActionCable.server.broadcast "status_channel",
                                 users: User.online.as_json
  end
end
