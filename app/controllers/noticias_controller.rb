class NoticiasController < ApplicationController
  before_action :set_noticia, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update]

  def index

    query = params[:query]

    if query.blank?
      obter_noticias
    else
      @noticias = Noticia.pesquisar_no_elasticsearch(query, params[:pagina_pesquisa])
      render "search.js.erb"
    end
  end

  def carregar_mais
    obter_noticias
  end

  def show
    @title = @noticia.titulo
  end

  def new
    @noticia = Noticia.new
  end

  def create
    @noticia = Noticia.new(noticia_params)
    @noticia.save
    redirect_to noticias_url
  end

  def edit
  end

  def update
    @noticia.update(noticia_params)
    redirect_to noticias_url
  end

  private
  def set_noticia

    id = params[:id]

    if !id.is_a? Integer
      id = id.split("-")[0]
    end

    @noticia = Noticia.find(id)
  end

  def noticia_params
    params.require(:noticia).permit(:titulo, :corpo)
  end

  def obter_noticias
    @noticias = Noticia.obter_noticias params[:pagina]
  end
end
