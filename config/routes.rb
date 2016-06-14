Rails.application.routes.draw do
  get 'comments/show'

resources :labels, only: [:show]

resources :topics do
  resources :posts, except: [:index]
end

resources :posts, only: [] do
  resources :comments, only: [:create, :destroy]
end

resources :topics, only: [:create, :destroy]

resources :users, only: [:new, :create]

resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  root to: 'welcome#index'

  get 'welcome/FAQ'

end
