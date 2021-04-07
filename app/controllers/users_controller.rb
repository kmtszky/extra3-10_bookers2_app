class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
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
