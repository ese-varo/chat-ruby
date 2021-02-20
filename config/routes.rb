Rails.application.routes.draw do
  root "pages#index"
  resources :users, only: [:new, :create]
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :conversations do
    resources :messages, only: [:new, :create, :destroy]
  end

  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in
  get '/start_conversation', to: 'users#start_conversation'
end
