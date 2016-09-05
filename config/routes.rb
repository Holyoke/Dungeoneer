Rails.application.routes.draw do

  devise_for :users

  root 'static_pages#root'

  resources :projects do
    resources :areas, only: [:index]
  end

  resources :areas, except: [:index]
  resources :users


  #API
  namespace :api,  defaults: {format: 'json'} do
    namespace :v1 do
      resources :projects, except: [:new, :edit]
      resources :areas, except: [:new, :edit]
      resources :marker, except: [:new, :edit]
    end
  end

  resource :api_session, only: [:create, :destroy], controller: 'sessions'
end
