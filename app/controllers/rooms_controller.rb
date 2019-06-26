class RoomsController < ApplicationController
  before_action :set_room, only: [:show]

  def index
    @rooms = Room.all
    @room = Room.new
  end

  def show;
    @users = User.all.per 10
  end

  def create
    @room = Room.create!

    redirect_to @room, notice: 'Room was successufully created.'
  end

  private

  def set_room
    @room = Room.find_by(token: params[:token])
  end
end
