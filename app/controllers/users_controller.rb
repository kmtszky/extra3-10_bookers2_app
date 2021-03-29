class UsersController < ApplicationController
  before_action :user_find, only: [:show, :edit, :update]

  def show
  end

  def index
    @users = User.all
  end

  def edit
    @user.save
    redirect_to user_path(@user.id)
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_find
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
