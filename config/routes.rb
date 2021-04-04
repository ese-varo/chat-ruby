Rails.application.routes.draw do
  root "pages#index"
  resources :users, only: [:new, :create, :edit, :show]
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :conversations do
    resources :messages
  end

  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in
  get '/start_conversation', to: 'conversations#start_conversation'
  get '/join_conversation', to: 'conversations#join'
  get '/shared_conversation', to: 'conversations#shared_conversation'
  get '/profile/:id', to: 'conversations#profile', as: 'profile'
end
