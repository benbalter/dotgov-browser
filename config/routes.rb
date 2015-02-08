Rails.application.routes.draw do
  resources :agencies

  resources :domains
  root "domains#index"
end
