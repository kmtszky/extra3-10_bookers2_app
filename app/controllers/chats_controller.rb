class ChatsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    room_ids = current_user.user_rooms.pluck(:room_id)                  # current_userがDMしているroomのroom_idをすべて抜き出す
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: room_ids) # @user(チャット相手)が、room_idsに入っているroomを抜き出す
    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params) # 2行分を省略して記載
    @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
