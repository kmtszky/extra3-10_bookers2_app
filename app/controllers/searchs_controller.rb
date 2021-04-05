class SearchsController < ApplicationController
  def index
    if params[:search_key]
      @category = params[:category]
      search = params[:search]
      search_key = params[:search_key]

      if @category == 'user_model'
        @user = User.search(search, search_key)
      else
        @book = Book.search(search, searcsh_key)
      end
    else
      flash[:ellors_explanation] = 'please input some words'
      redirect_back(fallback_location: books_path)
    end
  end
end
