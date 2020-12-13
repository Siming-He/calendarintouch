Rails.application.routes.draw do
  get 'page/home'
  
  resources :stages
  resources :tasks
  resources :subjects
  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }
    #:omniauth_callbacks => "callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'page#home'

end
