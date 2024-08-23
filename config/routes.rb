Rails.application.routes.draw do
  root 'welcome#index'
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: %i[show create] do
    resources :discover, only: [:index]
    resources :movies, only: %i[index show] do
      resources :viewing_parties, only: %i[new create]
    end
  end
end
