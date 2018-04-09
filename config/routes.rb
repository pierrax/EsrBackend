Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    post 'auth/register', to: 'users#register', as: :register
    post 'auth/login', to: 'users#login', as: :login

    get 'test', to: 'users#test'
    resources :users
    resources :institutions do
      resources :institution_names
      resources :addresses
      resources :links, only: [:create, :index]
      resources :codes, only: [:create, :index]
    end
    resources :links, only: [:show, :update, :destroy]
    resources :codes, only: [:show, :update, :destroy]
    resources :category_links
    resources :category_codes
    post 'institutions/search', to: 'institutions#search'
  end
end
