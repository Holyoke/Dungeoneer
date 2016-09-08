Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "registrations"
  }

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :users, only: [] do
    resources :projects, only: [:index]
  end

  resources :invites

  resources :projects do
    resources :areas, only: [:index, :new]
  end

  resources :areas, except: [:index, :new]

  resources :users


  #API
  namespace :api,  defaults: {format: 'json'} do
    namespace :v1 do
      resources :projects, except: [:new, :edit]
      resources :areas, except: [:new, :edit]
      resources :marker, except: [:new, :edit]
      resource :session, only: [:create, :destroy], controller: 'sessions'
    end
  end
end
