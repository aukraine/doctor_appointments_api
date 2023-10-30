Rails.application.routes.draw do
  post :login, controller: 'application'

  scope :doctor do
    resources :time_slots, only: [:index, :create, :update, :destroy]
  end
  scope :patient do
    resources :appointments, only: [:index, :create, :update, :destroy]

    namespace 'time_slots' do
      get :open, action: 'show_open'
    end
  end
end
