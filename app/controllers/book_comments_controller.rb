class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
    else
      flash[:notice] = "Please enter a comment of at least one character"
      @book = Book.find(params[:book_ird])
      @user = @book.user
      render 'books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
  end

  private

  def comment_params
    params.require(:book_comment).permit(:comment)
  end
end
