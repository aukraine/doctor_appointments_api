Rails.application.routes.draw do
  post :login, controller: 'application'

  resources :doctor_availabilities, only: [:index, :create, :update, :destroy]
  resources :appointments, only: [:index, :show, :create, :update, :destroy]
end
