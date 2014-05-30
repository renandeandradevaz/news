News::Application.routes.draw do

  root 'noticias#index'
  devise_for :users

  get "noticias/pesquisar"
  get "noticias/listar_categorias"

  resources :noticias
end
