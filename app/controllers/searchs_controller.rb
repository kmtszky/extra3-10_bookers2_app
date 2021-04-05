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
      flash[:ellors_explanation] = "please input some words"
      redirect_back(fallback_location: user_path(current_user))
    end
  end
end
