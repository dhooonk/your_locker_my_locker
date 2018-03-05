Rails.application.routes.draw do

  root 'index#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :locker, only: [:index, :create]
  get "/locker/applchem" => "locker#applchem", as: :applchem

  resources :time_limits, only: [:index, :update]
  resources :admin
end
