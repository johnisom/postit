PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'

  resources :posts, except: %i[destroy] do
    post 'vote', on: :member

    resources :comments, only: %i[create]
  end

  resources :categories, only: %i[new create show]
  resources :users, only: %i[show create edit update]
end
