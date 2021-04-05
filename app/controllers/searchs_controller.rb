class SearchsController < ApplicationController
  def index
    #キーワードが入力されていれば、whereメソッドとLIKE検索（部分一致検索）を組み合わせて、必要な情報のみ取得する。
    if params[:search_key]
      @results = Book.where('title LIKE ?', "%#{params[:search_key]}%").where('body LIKE ?', "%#{params[:search_key]}%")
    else
      @results = Book.all
    end
  end
  
  private
  
  def select(book, user)
    
end
