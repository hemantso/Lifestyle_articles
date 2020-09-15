# frozen_string_literal: true

Rails.application.routes.draw do
  resources :categories, except: [:destroy]
  resources :articles do 
    resources :votes
  end
  root to: "categories#index"
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'
end
