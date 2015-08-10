Rails.application.routes.draw do
  mount_roboto
  resources :agencies

  resources :domains
  root :to => redirect('/domains')
end
