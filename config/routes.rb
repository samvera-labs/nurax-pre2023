require 'sidekiq/web'

Rails.application.routes.draw do
  mount Riiif::Engine => 'images', as: :riiif if Hyrax.config.iiif_image_server?
  # This needs to appear before Hyrax's routes else sign_in and sign_out break
  devise_for :users

  mount BrowseEverything::Engine, at: '/browse'
  mount Qa::Engine => '/authorities'
  mount Sidekiq::Web => '/sidekiq'
  mount Blacklight::Engine, at: '/'
  mount Hyrax::Engine, at: '/'

  concern :exportable, Blacklight::Routes::Exportable.new
  concern :searchable, Blacklight::Routes::Searchable.new

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
