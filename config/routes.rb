Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    post 'auth/register', to: 'users#register'
    post 'auth/login', to: 'users#login'

    get 'test', to: 'users#test'
    resources :users
    resources :institutions do
      resources :institution_names
    end
  end
end
