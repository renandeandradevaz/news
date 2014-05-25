News::Application.routes.draw do

  root 'noticias#index'
  devise_for :users

  get "noticias/carregar_mais"

  resources :noticias
end
