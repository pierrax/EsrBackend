Rails.application.routes.draw do
  get 'db_schema', to: redirect('/database_schema.pdf')

  namespace :api do
    get 'institutions/last', to: 'institutions#last'
    resources :institutions do
      resources :institution_names, only: [:create, :index]
      resources :addresses, only: [:create, :index]
      resources :links, only: [:create, :index]
      resources :codes, only: [:create, :index]
      resources :institution_categories, only: [:create, :index]

      get 'tags', to: 'institution_taggings#index'
      post 'tags/:tag_id', to: 'institution_taggings#create'
      put 'tags/:tag_id', to: 'institution_taggings#update'
      delete 'tags/:tag_id', to: 'institution_taggings#delete'

      post 'predecessors', to: 'institution_evolutions#create_predecessor'
      get 'predecessors', to: 'institution_evolutions#index_predecessors'
      put 'predecessors/:predecessor_id', to: 'institution_evolutions#update_predecessor'
      delete 'predecessors/:predecessor_id', to: 'institution_evolutions#destroy_predecessor'

      post 'followers', to: 'institution_evolutions#create_follower'
      get 'followers', to: 'institution_evolutions#index_followers'
      put 'followers/:follower_id', to: 'institution_evolutions#update_follower'
      delete 'followers/:follower_id', to: 'institution_evolutions#destroy_follower'

      post 'mothers', to: 'institution_connections#create_mother'
      get 'mothers', to: 'institution_connections#index_mothers'
      put 'mothers/:mother_id', to: 'institution_connections#update_mother'
      delete 'mothers/:mother_id', to: 'institution_connections#destroy_mother'

      post 'daughters', to: 'institution_connections#create_daughter'
      get 'daughters', to: 'institution_connections#index_daughters'
      put 'daughters/:daughter_id', to: 'institution_connections#update_daughter'
      delete 'daughters/:daughter_id', to: 'institution_connections#destroy_daughter'

    end
    post 'institutions/import', to: 'institutions#import'
    post 'institutions/search', to: 'institutions#search'

    post 'addresses/import', to: 'addresses#import'
    post 'addresses/export', to: 'addresses#export'

    post 'codes/import', to: 'codes#import'
    post 'codes/export', to: 'codes#export'

    post 'connections/import', to: 'institution_connections#import'
    post 'connections/export', to: 'institution_connections#export'

    post 'links/import', to: 'links#import'
    post 'links/export', to: 'links#export'

    post 'taggings/import', to: 'institution_taggings#import'
    post 'taggings/export', to: 'institution_taggings#export'

    post 'evolutions/import', to: 'institution_evolutions#import'
    post 'evolutions/export', to: 'institution_evolutions#export'

    resources :links, only: [:show, :update, :destroy]
    resources :codes, only: [:show, :update, :destroy]
    post 'codes/search', to: 'codes#search'
    resources :institution_names, only: [:show, :update, :destroy]
    resources :addresses
    resources :institution_categories, only: [:show, :update, :destroy]
    resources :link_categories
    resources :code_categories
    resources :institution_category_labels
    resources :institution_tag_categories
    resources :institution_tags
    resources :institution_taggings
    resources :institution_evolution_categories
    resources :institution_connection_categories
  end
  match '*path', to: 'api/base#catch_404', via: :all
end
