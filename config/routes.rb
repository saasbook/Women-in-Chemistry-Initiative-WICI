Rails.application.routes.draw do
  resources :events
  root 'home#home'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'contact-me', to: 'messages#new', as: 'new_message'
  # ^ creates a route named new_message_url which maps GET requests
  #for http://localhost:3000/contact-me to an action named MessagesController#new.
  post 'contact-me', to: 'messages#create', as: 'create_message'
  #This route specifies that POST requests to http://localhost:3000/contact-me
  # should be handled by an action called MessagesController#create.
end
