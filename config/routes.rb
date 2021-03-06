News::Application.routes.draw do

  root 'noticias#index'
  devise_for :users

  get "noticias/pesquisar"
  get "noticias/listar_categorias"
  get "noticias/pesquisar_por_categoria"
  get "noticias/noticias_relacionadas"

  resources :noticias
end
