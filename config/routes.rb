Rails.application.routes.draw do
  post '/login' => 'sessions#create', as: :login
  delete '/logout' => 'sessions#destroy', as: :logout
  resources :users, :only => [:show, :create, :update, :destroy]
  resources :diaries do
    resources :entries
  end
  devise_for :users, controllers: {sessions: "sessions"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
