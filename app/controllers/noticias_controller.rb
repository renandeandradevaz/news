class NoticiasController < ApplicationController
  before_action :set_noticia, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update]

  def index

    #basta cercar o código com o profile start and stop para analisar o código
    #RubyProf.start

    @query = params[:query]
    @pagina = params[:pagina]
    @categoria = params[:categoria]

    if @query.present?
      @noticias = Noticia.pesquisar_no_elasticsearch(@query, @pagina)

    elsif @categoria.present?
      @noticias = Noticia.pesquisar_por_categoria(@categoria, @pagina)

    else
      @noticias = Noticia.obter_noticias @pagina
      if @pagina.present?
        render_index_js
      end
    end

    #UtilProfile.salvar_resultado_profile(RubyProf.stop)
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

  def noticias_relacionadas

    titulo = params[:titulo]
    @noticias = Noticia.pesquisar_por_titulo(titulo, 10)
    @noticias_relacionadas = Array.new

    @noticias.each do |noticia|
      if noticia.titulo != titulo
        @noticias_relacionadas << noticia
      end
    end
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
