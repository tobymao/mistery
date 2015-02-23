Rails.application.routes.draw do
  root 'landing#index'

  # Resources
  resources :universes

  resources :users do
    resources :plays, shallow: true, only: [:index, :create]
  end

  resources :plays, only: [:index, :show] do
    member do
      get 'location/:location_id', to: 'plays#visit', as: :visit
      post 'location', to: 'plays#book', as: :book
    end
  end

  resources :scenarios do
    resources :contacts
    resources :questions
  end

  # Login Controller
  get 'login' => 'login#index'
  post 'login' => 'login#login'
end
