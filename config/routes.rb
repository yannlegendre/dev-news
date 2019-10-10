Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'themes#index'

  resources :themes, only: [:index]

  resources :upvotes, only: [:create]

end
