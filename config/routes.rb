Rails.application.routes.draw do
  devise_for :users
  root to: 'themes#index'

  resources :themes, only: [:index] do
    collection do
      get :search
    end
  end

end
