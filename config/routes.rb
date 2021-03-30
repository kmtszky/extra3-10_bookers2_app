Rails.application.routes.draw do
  # homes
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  # users
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]

  # books, comments
  resources :books, only: [:show, :index, :create, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
