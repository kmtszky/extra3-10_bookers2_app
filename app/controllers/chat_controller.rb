class ChatController < ApplicationController
  def show
    @user = User.find(params[:id])                    #params[:id] => チャット相手show pageのid
    @cu_rooms = UserRoom.where(user_id: current_user) #current_userが参加しているルームをすべて取り出す
    @u_rooms = UserRoom.where(user_id: @user.id)      #@userが参加しているルームをすべて取り出す
    unless current_user.id == @user.id
      @cu_rooms.each do |cu_room|                    #user_aが参加しているルームをひとつずつcu_roomへ格納
        @u_rooms.each do |u_room|                    #user_bが参加しているルームをひとつずつu_roomへ格納
          if cu_room.room_id == u_room.room_id
            @room_id = cu_room.room_id
          else
            @room = Room.new
            @user_room = UserRoom.new
          end
        end
      end
    end
  end
end
