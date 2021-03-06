class User < ApplicationRecord
  before_create :generate_nickname

  scope :online, -> { where(online: true) }
  scope :offline, -> { where(online: false) }

  # after_update_commit { RoomBroadcastJob.perform_later self }

  def as_json
    { nickname: nickname, online: online }
  end

  private

  def generate_nickname
    self.nickname = Faker::Name.first_name.downcase
  end
end
