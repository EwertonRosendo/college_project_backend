Rails.application.routes.draw do
  resources :places
  resources :users
  post 'login', to: 'authentication#login'
end
