Rails.application.routes.draw do


get '/login', to: 'sessions#new'
post '/sessions', to: 'sessions#create'
delete '/sessions', to: 'sessions#destroy'

resources :users
  get '/profile', to: 'users#show'
  get '/signup', to: 'users#new'

resources :posts do
 resources :comments, shallow: true, only:[:create, :destroy]
end
root 'posts#index'

end