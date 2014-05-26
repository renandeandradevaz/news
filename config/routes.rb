News::Application.routes.draw do

  root 'noticias#index'
  devise_for :users

  get "noticias/search"

  resources :noticias
end
