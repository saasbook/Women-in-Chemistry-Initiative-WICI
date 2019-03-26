Rails.application.routes.draw do
  resources :events do
    resources :volunteers, :only => [:index, :create, :new, :destroy]
  end
  root 'home#home'

  #match "events/:id/volunteers", to: 'events#volunteers', via: :all, as: 'event_volunteers'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
