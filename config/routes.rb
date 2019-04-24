Rails.application.routes.draw do
  get 'tickets/check'

  resources :events do
    resources :guests, only: [:new, :create, :destroy] do
      get 'ticket/check', to: 'tickets#check', as: 'check_ticket'
    end

    resources :tasks do
      resources :assignments, except: [:show, :update]
    end
  end

  devise_for :volunteers
  devise_for :admins
  resources :about, only: [:index]
  resources :donations, only: [:index, :new, :create]

  get 'past-events', to: 'events#past_events', as: 'past_events'
  root 'home#home'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'contact', to: 'messages#new', as: 'new_message'
  # ^ creates a route named new_message_path which maps GET requests
  #for http://localhost:3000/contact to an action named MessagesController#new.
  post 'contact', to: 'messages#create', as: 'create_message'
  #This route specifies that POST requests to http://localhost:3000/contact-me
  # should be handled by an action called MessagesController#create.
end
