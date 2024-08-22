Rails.application.routes.draw do
  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    resource :discover, only: [:index]
    resources :movies, only: [:index, :show]
  end
end
