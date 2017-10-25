Rails.application.routes.draw do
  resources :diaries do
    resources :entries
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
