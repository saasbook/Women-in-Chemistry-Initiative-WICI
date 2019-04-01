Rails.application.routes.draw do
  resources :events
  get '/home/past_speakers', to: 'events#past_speakers', as: "past_speakers"
  root 'home#home'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
