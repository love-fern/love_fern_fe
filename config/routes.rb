Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  delete '/session', to: 'sessions#delete'

  # dashboard
  get '/greenhouse', to: 'users#show'
  get '/about', to: 'about#index'
  get '/ferns/:id/water', to: 'ferns#edit', as: :water_fern
  get '/ferns/:id/fertilize', to: 'ferns/activities#index', as: :fertilize_fern

  resources :ferns, only: %i[new create show destroy update]
  resources :shelves, only: %i[new create]
end
