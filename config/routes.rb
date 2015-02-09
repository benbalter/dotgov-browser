Rails.application.routes.draw do
  resources :agencies

  resources :domains
  root :to => redirect('/domains')
end
