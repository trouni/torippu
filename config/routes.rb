Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :trips, only: [:index, :show, :new, :create, :edit, :update] do
    resources :bookings, only: [:create, :update]
  end
  namespace :user do
    resources :trips, only: :index
  end
  resources :bookings, only: :destroy
end
