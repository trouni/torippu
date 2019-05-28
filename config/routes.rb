Rails.application.routes.draw do
  get 'bookings/new'
  devise_for :users
  root to: 'pages#home'
  resources :trips, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      resources :bookings, only: [:create, :update]
    end
  end
  namespace :user do
    resources :trips, only: :index
  end
end
