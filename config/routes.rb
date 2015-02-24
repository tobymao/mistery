Rails.application.routes.draw do
  root 'landing#index'

  # Resources
  resources :universes
  resources :users

  resources :plays, only: [:index, :show, :create] do
    resources :guesses

    member do
      get 'visit/:location_id', to: 'plays#visit', as: :visit
      post 'visit', to: 'plays#book', as: :book
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
