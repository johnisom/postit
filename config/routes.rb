PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :posts, except: %i[destroy] do
    resources :comments, only: %i[create]
  end

  resources :categories, only: %i[new create show]
end
