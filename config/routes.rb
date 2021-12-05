Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  get 'favorites/update'
  get 'favorites/index', to: 'favorites#index'
  get '/search', to: "reviews#search"
  get '/tagged', to: "reviews#tagged", as: :tagged

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

  
end
