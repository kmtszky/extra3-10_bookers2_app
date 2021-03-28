Rails.application.routes.draw do
  get 'books/show'
  get 'books/index'
  get 'books/edit'
  devise_for :users

  root to: 'homes#top'
  get 'about' => 'homes#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
