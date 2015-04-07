Rails.application.routes.draw do
  root 'landing#index'

  # Resources
  resources :universes

  resources :users do
    member do
      get 'universes', to: 'users#universes', as: :universes
      get 'scenarios', to: 'users#scenarios', as: :scenarios
      put 'reset_password', to: 'users#reset_password', as: :reset_password
    end
  end

  resources :plays, only: [:index, :show, :create, :update] do
    resources :guesses, only: :index do
      collection do
        post 'start', to: 'guesses#start', as: :start
      end
    end

    member do
      get 'visit/:location_id', to: 'plays#visit', as: :visit
      post 'visit', to: 'plays#book', as: :book
      get 'result', to: 'plays#result', as: :result
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
  get 'reset_password' => 'login#reset_password'
  get 'forgot_username' => 'login#forgot_username'
  get 'forgot_password' => 'login#forgot_password'
  post 'send_username' => 'login#send_username'
  post 'send_password' => 'login#send_password'
end
