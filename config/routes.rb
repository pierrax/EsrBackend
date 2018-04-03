Rails.application.routes.draw do
  devise_for :users

  root to:  'api/users#test'

  namespace :api do
    post 'auth/register', to: 'users#register', as: :register
    post 'auth/login', to: 'users#login', as: :login

    get 'test', to: 'users#test'
    resources :users
    resources :institutions do
      resources :institution_names
      resources :addresses
    end
  end
end
