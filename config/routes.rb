Rails.application.routes.draw do
  resources :posts
  resources :photos, only: [:new, :create, :index, :destroy]
  resources :documents
  resources :products do
    post :charge, on: :collection
  end
  root to: 'welcome#index'
end
