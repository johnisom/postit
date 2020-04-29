PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: %i[destroy]
  resources :categories, only: %i[new create show]
end
