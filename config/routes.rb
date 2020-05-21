Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get '/facilities/room/new/:facility_id', to: 'rooms#new'
  get '/rooms/allocation/new/:room_id', to: 'allocations#new'
  get '/rooms/reservation/new/:allocation_id', to: 'reservations#new'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  resources :facilities
  resources :rooms
  resources :allocations
  resources :timeslots
  resources :reservations
  
end
