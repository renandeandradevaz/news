class NoticiasController < ApplicationController
  before_action :set_noticia, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update]

  def index
    @query = params[:query]
    @pagina = params[:pagina]

    if @query.blank?

      @noticias = Noticia.obter_noticias @pagina

      if @pagina.present?
        render_index_js
      end

    else
      @noticias = Noticia.pesquisar_no_elasticsearch(@query, @pagina)
    end
  end

  def render_index_js
    render "index.js.erb"
  end

  def pesquisar
    params[:pagina] = 1
    index
    render_index_js
  end

  def listar_categorias
    render :json => Noticia.listar_categorias
  end

  def pesquisar_por_categoria
    @categoria = params[:categoria]
    @pagina = 1
    @noticias = Noticia.pesquisar_por_categoria(@categoria, @pagina)
    render_index_js
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
    params.require(:noticia).permit(:titulo, :corpo, :categoria)
  end
end
