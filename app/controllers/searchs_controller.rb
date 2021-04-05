class SearchsController < ApplicationController
  def index
    #キーワードが入力されていれば、whereメソッドとLIKE検索（部分一致検索）を組み合わせて、必要な情報のみ取得する。
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
