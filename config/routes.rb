Rails.application.routes.draw do
  resources :posts
  resources :photos, only: [:new, :create, :index, :destroy]
  root to: 'welcome#index'
end
