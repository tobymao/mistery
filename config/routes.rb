Rails.application.routes.draw do
  root 'landing#index'

  # Resources
  resources :universes
  resources :locations
  resources :plays, only: :index
  resources :users do
    resources :plays, shallow: true, only: [:index, :show, :create]
  end
  resources :scenarios do
    resources :contacts
    resources :questions
  end

  # Login Controller
  get 'login' => 'login#index'
  post 'login' => 'login#login'
end
