Rails.application.routes.draw do
  resources :areas, except: [:index]

  resources :projects do
    resources :areas, only: [:index]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
