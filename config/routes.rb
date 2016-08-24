Rails.application.routes.draw do

  devise_for :users

  root 'static_pages#root'

  resources :areas, except: [:index]
  resources :users

  resources :projects do
    resources :areas, only: [:index]
  end

  #API
  namespace :api,  defaults: {format: 'json'} do
    namespace :v1 do
      resources :projects, except: [:new, :edit]
      resources :areas, except: [:new, :edit]
    end
  end
end
