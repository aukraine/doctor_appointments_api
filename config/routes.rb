Rails.application.routes.draw do
  post :login, controller: 'application'

  resources :time_slots, only: [:index, :create, :update, :destroy]
  resources :appointments, only: []
end
