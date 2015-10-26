Rails.application.routes.draw do

  get '/search', to: 'home#search', as: 'search'

  root 'home#index'
end
