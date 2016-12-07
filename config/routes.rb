Rails.application.routes.draw do
  resources :users

  root to: 'users#index'
  resource :session, only: [:new, :create, :destroy]
  get "/session" => "sessions#new"
  get '/login' => 'sessions#new'
  get '/logout' => 'sessions#destroy'
end
