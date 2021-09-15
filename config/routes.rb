Rails.application.routes.draw do
  root to: 'users#index'

  # except - про то каких экшенов не будет в этом ресурсе/контроллере
  # only - какие конкретно будут.
  # Для сессии - единств. число, т.к. у каждого юзера одна собств-я сессия
  resource :session, only: %i[new create destroy]
  resources :users
  resources :questions, except: %i[show new index]
  resources :hashtags, only: :show, param: :name
end
