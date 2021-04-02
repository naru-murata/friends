Rails.application.routes.draw do
  
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  
  resources :users do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  resources :posts, only: [:create, :destroy, :edit, :update, :show] 
  
  resources :relationships, only:[:create, :destroy]
  
  resources :favorites, only:[:create, :destroy]
  
end
