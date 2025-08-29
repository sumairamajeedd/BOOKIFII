Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :books do
    resources :user_books, only: [:create]
    collection do
      get :recommended
    end
  end

  # Landing page
  root "pages#index"

  # Static pages
  get "features",     to: "pages#features"
  get "testimonials", to: "pages#testimonials"
  get "blog",         to: "pages#blog"
  get "contact",      to: "pages#contact"
require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'

  # Rails health check
  get "up" => "rails/health#show", as: :rails_health_check
end
