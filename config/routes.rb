CareHomeSearch::Application.routes.draw do
  resources :searches, only: [:new, :create, :show]
  resources :care_homes
  root 'searches#new'
end
