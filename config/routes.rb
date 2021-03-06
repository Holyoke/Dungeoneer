Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "registrations"
  }

  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end

  resources :users, only: [] do
    resources :maps, only: [:index]
  end

  resources :invites

  resources :maps do
    resources :areas, only: [:new]
    resources :members, only: :index
  end

  resources :areas, except: [:index, :new]

  resources :users

  #static pages
  root "static_pages#root"


  #API
  namespace :api,  defaults: {format: 'json'} do
    namespace :v1 do
      resources :maps, except: [:new, :edit]
      resources :areas, except: [:new, :edit]
      resources :pins, except: [:new, :edit]
      resource :session, only: [:create, :destroy], controller: 'sessions'
    end
  end
end
