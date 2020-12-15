Rails.application.routes.draw do
  resources :events
  resources :tasks
  resources :subjects
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'page#home'
  get '/calendar', to: 'calendar#show'

  resources :users do
    resources :subjects, only: [:create, :destroy]
  end

  resources :subjects do
    resources :tasks
  end

  get 'add_subject/:user_id/:subject_id', to: 'registration#add_subject'
  get 'drop_subject/:user_id/:subject_id', to: 'registration#drop_subject'

end
