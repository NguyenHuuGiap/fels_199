Rails.application.routes.draw do

  root "static_pages#index"
  get "contact", to: "static_pages#contact"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :users, expect: :destroy
  resources :suggest_questions
  namespace :admin do
    root "home#index", as: "root"
    resources :suggest_questions
    resources :categories
    resources :questions
    resources :answers
    resources :users
  end
end
