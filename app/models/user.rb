class User < ApplicationRecord
  before_create :generate_nickname

  after_update_commit { RoomBroadcastJob.perform_later self }

  private

  def generate_nickname
    self.nickname = Faker::Name.first_name.downcase
  end
end
