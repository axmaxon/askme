Rails.application.routes.draw do
  root to: 'users#index'
  # except - про то каких экшенов не будет в этом ресурсе/контроллере
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, except: [:destroy]
  resources :questions, except: [:show, :new, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'show' => 'users#show'
  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
end
