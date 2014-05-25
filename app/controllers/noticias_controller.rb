class NoticiasController < ApplicationController
  before_action :set_noticia, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update]


=begin

    #PESQUISA ELASTICSEARCH

    query = 'carro'

    response = HTTParty.get(Noticia::ENDERECO_NOTICIAS_ELASTICSEARCH + "_search?q=#{query}&size=25&from=0", {
        :body => '{"sort": [{ "id": { "order": "desc" } } ] }'
    })

    @noticias = Array.new

    JSON.parse(response.body)['hits']['hits'].each do |hit|
      @noticias << Noticia.new(hit['_source'])
    end
=end


  def index
    obter_noticias
  end

  def carregar_mais
    obter_noticias
  end

  def obter_noticias
    @noticias = Noticia.obter_noticias params[:pagina]
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
end
