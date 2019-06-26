class RoomBroadcastJob < ApplicationJob
  queue_as :default

  def perform(user)
    ActionCable.server.broadcast "room_user", render_json(user)
  end

  private

  def render_json(user)
    ApplicationController.renderer.render(json: user)
  end
end
