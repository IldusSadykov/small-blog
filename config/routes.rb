Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :posts do
    resources :comments, only: %i(create show edit update destroy)
    resources :subscriptions, only: %i(create)
  end
  resources :users, only: [] do
    resources :posts, only: :index, module: :users
  end
  resources :categories, only: :show
  resources :plans
  resource :dashboard, controller: "dashboard", only: :show
  root to: 'dashboard#show'
end
