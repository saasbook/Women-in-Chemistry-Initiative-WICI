Rails.application.routes.draw do
  resources :events do
    resources :guests, only: [:new, :create, :destroy]
    resources :tasks do
      resources :assignments, except: [:update]
    end
  end

  devise_for :volunteers, controllers: {
    sessions: 'volunteers/sessions'
  }

  devise_scope :admin do
    get 'accounts', to: 'admins/registrations#index', as: 'accounts'
    post 'volunteer/:id/approve', to: 'volunteers/registrations#approve', as: 'approve_volunteer'
    delete 'volunteer/:id', to: 'volunteers/registrations#destroy', as: 'destroy_volunteer'
    post 'admin/:id/approve', to: 'admins/registrations#approve', as: 'approve_admin'
    delete 'admin/:id', to: 'admins/registrations#destroy', as: 'destroy_admin'
  end

  devise_for :admins, controllers: {
      sessions: 'admins/sessions'
  }


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
