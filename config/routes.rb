Rails.application.routes.draw do
  root 'landing#index'

  # Resources
  resources :universes
  resources :locations
  resources :scenarios
  resources :contacts
  resources :users
  resources :questions
  resources :plays

  # Login Controller
  get 'login' => 'login#index'
  post 'login' => 'login#login'
end
