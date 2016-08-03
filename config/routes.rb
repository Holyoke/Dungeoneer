Rails.application.routes.draw do
  resources :projects do
    resources :areas, only: [:index, :new]
  end

  resources :areas, except: [:index, :new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
