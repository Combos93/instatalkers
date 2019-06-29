class User < ApplicationRecord
  before_create :generate_nickname

  scope :online, -> { where(online: true) }

#  after_update_commit { RoomBroadcastJob.perform_later self }

  def as_json
    { nickname: nickname, online: online }
  end

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end

  private

  def generate_nickname
    self.nickname = Faker::Name.first_name.downcase
  end
end
