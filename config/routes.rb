# frozen_string_literal: true

Rails.application.routes.draw do
  
  root to: "categories#index"
  resources :categories, except: [:index, :destroy]
  
  resources :articles  do 
    resources :votes, only: [:destroy, :create]
  end


  
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end
