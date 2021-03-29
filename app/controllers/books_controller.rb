class BooksController < ApplicationController
  before_action :book_find, only: [:show, :edit, :update, :destroy]

  def show
    @book_new = Book.new
    @user = current_user
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
      redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    if @book.user_id != current_user.id
      render :show
    end
  end

  def update
    @book.user_id = current_user.id
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_find
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end
