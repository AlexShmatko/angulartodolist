Rails.application.routes.draw do

  match '/signup', to: 'users#new', via: 'get'
  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'
  match '/authenticate',  to: 'sessions#create', via: 'post'

  resources :tasks
  resources :users

  resources :password_resets

  root 'home#index'
end
