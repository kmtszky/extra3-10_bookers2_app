class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    @cu_rooms = UserRoom.where(user_id: current_user) #current_userが参加しているルームをすべて取り出す
    @u_rooms = UserRoom.where(user_id: @user.id)      #@userが参加しているルームをすべて取り出す
    unless current_user.id == @user.id
      @cu_rooms.each do |cu_room| #current_userが参加しているルームをひとつずつcu_roomへ格納
        @u_rooms.each do |u_room| #@userが参加しているルームをひとつずつu_roomへ格納
          if cu_room.room_id == u_room.room_id
            @room_id = cu_room.room_id
            @have_room = true
          else
            @room = Room.new
            @user_room = UserRoom.new
          end
        end
      end
    end
  end

  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  def follower
    @user = User.find(params[:id])
    @followers = @user.following_users
  end

  def followed
    @user = User.find(params[:id])
    @followeds = @user.followed_users
  end

  private

  def correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def zipedit
    params.require(:user).permit(:postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end
end
