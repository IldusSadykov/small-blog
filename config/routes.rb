Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, only: %i(create show)
  end
  resources :categories, only: :show
  root to: 'dashboard#index'
end
