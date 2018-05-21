# frozen_string_literal: true

Rails.application.routes.draw do
  get "login", to: redirect("/auth/google_oauth2"), as: "login"
  get "auth/google_oauth2/callback", to: "sessions#create"
  get "auth/failure", to: redirect("/")

  delete "logout", to: "sessions#destroy", as: "logout"

  get "search", to: "search#new"
  post "search", to: "search#questions"

  resources :questions, only: [:index, :create, :new, :show] do
    resources :answers, only: [:create, :new]
  end

  root to: "questions#index"
end
