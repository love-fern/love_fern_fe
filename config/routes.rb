Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  delete '/session', to: 'sessions#delete'  
  # dashboard
  get '/greenhouse', to: 'users#show'
  get '/about', to: 'about#index'
  resources :ferns, only: [:new, :create, :show]
end
