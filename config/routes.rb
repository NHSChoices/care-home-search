CareHomeSearch::Application.routes.draw do
  resources :searches, only: [:new, :create, :show]
  resources :providers, only: [:show]
  root 'searches#new'
end
