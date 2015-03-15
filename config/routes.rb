Rails.application.routes.draw do
  root 'landing#index'

  # Resources
  resources :universes

  resources :users do
    member do
      get 'universes', to: 'users#universes', as: :universes
      get 'scenarios', to: 'users#scenarios', as: :scenarios
    end
  end

  resources :plays, only: [:index, :show, :create] do
    resources :guesses, only: [:index, :new, :edit, :create] do
      collection do
        post 'start', to: 'guesses#start', as: :start
      end
    end

    member do
      get 'visit/:location_id', to: 'plays#visit', as: :visit
      post 'visit', to: 'plays#book', as: :book
      get 'result', to: 'plays#result', as: :result
      post 'finish', to: 'plays#finish', as: :finish
    end
  end

  resources :scenarios do
    resources :contacts
    resources :questions
  end

  # Login Controller
  get 'login' => 'login#index'
  post 'login' => 'login#login'
  post 'logout' => 'login#logout'
end
