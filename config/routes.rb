PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: %i[destroy] do
    resources :comments, only: %i[create]
  end

  resources :categories, only: %i[new create show]
end
