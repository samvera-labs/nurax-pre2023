Rails.application.routes.draw do
  mount Blacklight::Engine => '/'
  mount BrowseEverything::Engine => '/browse'
  mount Hyrax::Engine, at: '/'
  mount Qa::Engine => '/authorities'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  concern :exportable, Blacklight::Routes::Exportable.new
  concern :searchable, Blacklight::Routes::Searchable.new

  devise_for :users
  curation_concerns_basic_routes

  resources :bookmarks do
    concerns :exportable
    collection do
      delete 'clear'
    end
  end

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :welcome, only: 'index'
  root 'hyrax/homepage#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
