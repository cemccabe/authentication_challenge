Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  resources :users

  get '/register', to: 'users#new'
  # post '/users', to: 'users#create'
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'

  delete '/logout', to: 'users#logout_user'

  get '/dashboard', to: 'users#show'
end
