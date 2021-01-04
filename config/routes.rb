Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'chatroom#index'

  
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'message', to: 'messages#create'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'profile', to: 'users#profile'
  get 'profile/edit', to: 'users#edit'
  post 'profile/update', to: 'users#update'
  get 'users', to: 'users#show'
  get 'user/:id', to: 'user#show'
  post 'friendships', to: 'friendships#create'
  # post 'unlike', to: 'likes#destroy'
  resources :messages do
    resources :likes
  end

  resources :friendships
  # post 'friendships', to: 'friendships#destroy', method: delete

  mount ActionCable.server, at: '/cable'
end
