Rails.application.routes.draw do
  resources :appointments, only: [:index, :show, :create, :update, :destroy]
end
