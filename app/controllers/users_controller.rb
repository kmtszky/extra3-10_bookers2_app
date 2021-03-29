class UsersController < ApplicationController
  before_action :user_find, only: [:show, :edit, :update]

  def show
    @book = Book.new
    @books = @user.books
  end

  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  def edit
    if @user.id != current_user.id
      @books = @user.books
      render :show
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  private

  def user_find
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
