Rails.application.routes.draw do
  resources :projects, only: [:index, :create, :show] do
    resources :areas
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
