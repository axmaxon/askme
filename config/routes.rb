Rails.application.routes.draw do
  root to: 'users#index'
  # except - про то каких экшенов не будет в этом ресурсе/контроллере
  resources :users, except: [:destroy]
  resources :questions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'show' => 'users#show'
end
