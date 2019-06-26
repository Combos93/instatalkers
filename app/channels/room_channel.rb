class RoomChannel < ApplicationCable::Channel
  def subscribed
    logger.info "Subscribed to RoomChannel, roomId: #{params[:roomId]}"

    user = User.where(user_id: current_user.id).first
    return unless user
    user.online = true
    user.save!

    @room = Room.find(params[:roomId])

    stream_from "room_channel_#{@room.id}"

    speak('message' => '* * * joined the room * * *')
  end

  def unsubscribed
    logger.info "Unsubscribed to RoomChannel"

    user = User.where(user_id: current_user.id).first
    return unless user
    user.online = false
    user.save!

    speak('message' => '* * * left the room * * *')
  end

  def speak(data)
    logger.info "RoomChannel, speak: #{data.inspect}"

    MessageService.new(body: data['message'], user: current_user, room: @room).perform
  end
end
