Rails.application.routes.draw do
  # homes
  root to: 'homes#top'
  get 'home/about', to: 'homes#about'

  # users
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  resources :users, only: [:show, :index, :edit, :update]
  get '/users/:id/follower', to: 'users#follower', as: 'user_follower'
  get '/users/:id/followed', to: 'users#followed', as: 'user_followed'

  # books, comments
  resources :books, only: [:show, :index, :create, :edit, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  # relationships
  resources :relationships, only: [:destroy]
  post '/relationships/:id', to: 'relationships#create'

  # search
  resources :searchs, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
