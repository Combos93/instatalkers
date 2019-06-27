class User < ApplicationRecord
  before_create :generate_nickname

  after_update_commit { RoomBroadcastJob.perform_later self }

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end

  private

  def generate_nickname
    self.nickname = Faker::Name.first_name.downcase
  end
end
