# frozen_string_literal: true

Rails.application.routes.draw do
  get "login", to: redirect("/auth/google_oauth2"), as: "login"
  get "auth/google_oauth2/callback", to: "sessions#create"
  get "auth/failure", to: redirect("/")

  delete "logout", to: "sessions#destroy", as: "logout"

  resources :questions, only: [:index, :new, :create] do
    resources :answers, only: [:create]
  end

  root to: "questions#index"
end
