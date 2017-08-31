Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'charts#index', as: :root
  get '/charts', to: 'charts#index', as: :charts
  get '/charts/new', to: 'charts#new', as: :new_chart
  get '/charts/:id', to: 'charts#show', as: :chart
  post '/charts', to: 'charts#create'
end
