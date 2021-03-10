Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, except: [:new] do
    member do
      get :posts
      get :followings
      get :followers
    end
  end
  
  resources :posts, only: [:create, :destroy, :edit, :update, :show]
  resources :relationships, only:[:create, :destroy]
  
end
