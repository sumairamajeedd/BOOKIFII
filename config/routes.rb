Rails.application.routes.draw do
  devise_for :users

  resources :books do
    resources :user_books, only: [:create]   # nested routes
    collection do
      get :recommended   # ab ye recommended_books_path banayega
    end
  end

  root "pages#index"
  get "pages/index"

  get "features", to: "pages#features"
  get "testimonials", to: "pages#testimonials"
  get "blog", to: "pages#blog"
  get "contact", to: "pages#contact"

  get "up" => "rails/health#show", as: :rails_health_check
end
