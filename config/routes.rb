Rails.application.routes.draw do
  get 'tickets/check'

  resources :events do
    resources :guests, only: [:new, :create, :destroy] do
      get 'ticket/check', to: 'tickets#check', as: 'check_ticket'
    end

    resources :tasks do
      resources :assignments, except: [:update]
    end
  end

  resources :photos, except: [:show]
  resources :leaders, except: [:show, :index]

  devise_for :volunteers, controllers: {
    sessions: 'volunteers/sessions',
    registrations: 'volunteers/registrations',
    confirmations: 'volunteers/confirmations',
    passwords: 'volunteers/passwords'
  }


  devise_for :admins, controllers: {
      sessions: 'admins/sessions',
      registrations: 'admins/registrations',
      confirmations: 'admins/confirmations',
      passwords: 'admins/passwords'
  }

  devise_scope :admin do
    get 'accounts', to: 'admins/registrations#index', as: 'accounts'
    post 'volunteer/:id/approve', to: 'volunteers/registrations#approve', as: 'approve_volunteer'
    delete 'volunteer/:id', to: 'volunteers/registrations#destroy', as: 'destroy_volunteer'
    post 'admin/:id/approve', to: 'admins/registrations#approve', as: 'approve_admin'
    delete 'admin/:id', to: 'admins/registrations#destroy', as: 'destroy_admin'
  end

  resources :about, only: [:index]
  resources :donations, only: [:index, :new, :create]

  get 'past-events', to: 'events#past_events', as: 'past_events'
  get 'home', to: 'photos#home', as: 'home_path'
  root 'photos#home'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'contact', to: 'messages#new', as: 'new_message'
  # ^ creates a route named new_message_path which maps GET requests
  #for http://localhost:3000/contact to an action named MessagesController#new.
  post 'contact', to: 'messages#create', as: 'create_message'
  #This route specifies that POST requests to http://localhost:3000/contact-me
  # should be handled by an action called MessagesController#create.
end
