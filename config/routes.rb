Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'd'
  resources :users, :only =>[:show] do 
    member do
      patch :change_role
    end
  end
  resources :reviews
  
  root 'reviews#index'
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',     to: 'users#show',       via: 'get'
end
