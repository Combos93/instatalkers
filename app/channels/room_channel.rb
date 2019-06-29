class RoomChannel < ApplicationCable::Channel
  def subscribed
    redis.set("user_#{current_user.id}_online", "1")

    logger.info "Subscribed to RoomChannel, roomId: #{params[:roomId]}"

    user = User.where(id: current_user.id).first
    return unless user
    user.online = true
    user.save!

    @room = Room.find(params[:roomId])

    stream_from "room_channel_#{@room.id}"

  end

  def unsubscribed
    redis.del("user_#{current_user.id}_online")

    logger.info "Unsubscribed to RoomChannel"

    user = User.where(id: current_user.id).first
    return unless user
    user.online = false
    user.save!

  end

  def speak(data)
    logger.info "RoomChannel, speak: #{data.inspect}"

    MessageService.new(body: data['message'], user: current_user, room: @room).perform
  end

  private

  def redis
    Redis.new 
  end
end
