Rails.application.routes.draw do
  post :login, controller: 'application'

  resources :appointments, only: [:index, :show, :create, :update, :destroy]
end
