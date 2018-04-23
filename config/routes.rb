Rails.application.routes.draw do
  devise_for :users
  get 'db_schema', to: redirect('/erd.pdf')
  namespace :api do
    post 'auth/register', to: 'users#register', as: :register
    post 'auth/login', to: 'users#login', as: :login

    get 'test', to: 'users#test'
    resources :users
    resources :institutions do
      resources :institution_names, only: [:create, :index]
      resources :addresses, only: [:create, :index]
      resources :links, only: [:create, :index]
      resources :codes, only: [:create, :index]
      resources :institution_categories, only: [:create, :index]

      get 'tags', to: 'institutions#tags'
      post 'tags/:tag_id', to: 'institutions#add_tag'
      delete 'tags/:tag_id', to: 'institutions#remove_tag'

      post 'predecessors', to: 'institution_evolutions#create_predecessor'
      get 'predecessors', to: 'institution_evolutions#index_predecessors'
      put 'predecessors/:predecessor_id', to: 'institution_evolutions#update_predecessor'
      delete 'predecessors/:predecessor_id', to: 'institution_evolutions#destroy_predecessor'

      post 'followers', to: 'institution_evolutions#create_follower'
      get 'followers', to: 'institution_evolutions#index_followers'
      put 'followers/:follower_id', to: 'institution_evolutions#update_follower'
      delete 'followers/:follower_id', to: 'institution_evolutions#destroy_follower'
    end
    resources :links, only: [:show, :update, :destroy]
    resources :codes, only: [:show, :update, :destroy]
    resources :institution_names, only: [:show, :update, :destroy]
    resources :addresses
    resources :institution_categories, only: [:show, :update, :destroy]
    resources :link_categories
    resources :code_categories
    resources :institution_category_labels
    resources :institution_tag_categories
    resources :institution_tags
    resources :institution_evolution_categories
    post 'institutions/search', to: 'institutions#search'
  end
end
