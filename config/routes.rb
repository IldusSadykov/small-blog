Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :posts do
    resources :comments, only: %i(create show edit update destroy)
    resource :subscriptions, only: %i(create), module: :posts
  end
  resources :users, only: [] do
    resources :posts, only: :index, module: :users
  end
  resources :categories, only: :show
  resources :plans
  resource :dashboard, controller: "dashboard", only: :show
  namespace :webhooks do
    resource :subscriptions
  end
  resources :subscribed_posts, only: %i(index  destroy)
  root to: "dashboard#show"
end
