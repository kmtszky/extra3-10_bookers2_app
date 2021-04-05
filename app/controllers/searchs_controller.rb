class SearchsController < ApplicationController
  def index
    if params[:search_key].present?
      @category = params[:category]
      search = params[:search]
      @search_key = params[:search_key]

      if @category == 'user'
        @user = User.search(search, @search_key)
      else
        @book = Book.search(search, @search_key)
      end
    else
      @users = User.none
      @books = Book.none
    end
  end
end
