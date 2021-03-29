class BooksController < ApplicationController
  before_action :book_find, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def book_find
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end
