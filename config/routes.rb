Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index] do
    collection do
      get :edit_password
      patch :update_password
    end
  end

  resources :posts
  resources :photos, only: [:new, :create, :index, :destroy]
  resources :documents
  resources :products do
    post :charge, on: :collection
  end
  root to: 'welcome#index'
end
