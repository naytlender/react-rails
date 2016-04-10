Rails.application.routes.draw do
  devise_for :users, only: []

  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create, :destroy], controller: :sessions
    resources :users, only: [:index, :create, :show, :update, :destroy]
  end
end
