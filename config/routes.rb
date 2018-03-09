Rails.application.routes.draw do

  root 'index#index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  #index(main&User)
  get "/index/myinfo"
  get "/index/privacy" =>"index#privacy"
  get "/index/partner" =>"index#partner"
  get "/index/service" =>"index#service"

  #locker apply
  resources :locker, only: [:index, :create]
  get "/locker/applchem" => "locker#applchem"
  post "/locker/applchem" => "locker#create"
  delete "/locker/destroyApplchem/:id" => "locker#destroyApplchem"

  #admin
  resources :admin, only: [:index, :destroy, :edit, :update]
  get "/admin/time"

  #route security
  match '*path' => redirect('/'), via: :get
get '/rails/info/routes' => redirect('/')
end
