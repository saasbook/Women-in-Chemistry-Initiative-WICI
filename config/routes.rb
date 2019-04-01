Rails.application.routes.draw do
  resources :events
  resources :guests
  root 'home#home'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
