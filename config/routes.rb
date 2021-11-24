Rails.application.routes.draw do
  get 'profile/index'
  match '/users',   to: 'users#index',   via: 'get'
  devise_for :users
  resources :reviews
  
  root 'reviews#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
