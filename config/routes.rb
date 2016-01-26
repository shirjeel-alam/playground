Rails.application.routes.draw do
  resources :posts
  resources :photos, only: [:new, :create, :index, :destroy]
  resources :documents
  root to: 'welcome#index'
end
