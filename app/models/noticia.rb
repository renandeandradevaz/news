class Noticia < ActiveRecord::Base
  after_save :after_save

  self.table_name = "noticias"

  ENDERECO_NOTICIAS_ELASTICSEARCH = "http://localhost:9200/noticias/"
  LIMITE_NOTICIAS_POR_PAGINA = 1
  LIMITE_PAGINAS_NO_CACHE = 4

  def after_save
    definir_url
    indexar_no_elasticsearch
    Noticia.salvar_no_redis
  end

  def definir_url

    url = self.id.to_s + '-' + self.titulo.gsub(' ', '-')

    self.update_column("url", url)
  end

  def indexar_no_elasticsearch
    indexado_no_elasticsearch = false

    begin
      response = HTTParty.post(ENDERECO_NOTICIAS_ELASTICSEARCH + "noticia/#{self.id}", {
          :body => {"titulo" => self.titulo,
                    "corpo" => self.corpo,
                    "url" => self.url,
                    "id" => self.id
          }.to_json
      }
      )
      if response.code == 200 or response.code == 201
        indexado_no_elasticsearch = true
      end

    rescue Exception
      puts $!, $@
    end

    self.update_column("indexado_no_elasticsearch", indexado_no_elasticsearch)
  end

  def self.salvar_no_redis
    for pagina in 1..LIMITE_PAGINAS_NO_CACHE
      noticias_da_pagina = buscar_noticias_do_banco(pagina)
      $redis.set("noticias_pagina_#{pagina}", noticias_da_pagina.to_json)
    end
  end

  def self.buscar_noticias_do_banco(pagina)
    offset = pagina - 1
    Noticia.select(:titulo, :url).order(id: :desc).limit(LIMITE_NOTICIAS_POR_PAGINA).offset(LIMITE_NOTICIAS_POR_PAGINA * offset)
  end

  def self.obter_noticias(pagina=nil)

    if pagina.blank?
      pagina = 1
    else
      pagina = pagina.to_i
    end

    if pagina > LIMITE_PAGINAS_NO_CACHE
      buscar_noticias_do_banco(pagina)
    else
      noticias_json = obter_noticias_da_pagina(pagina)

      if noticias_json.blank?
        Noticia.salvar_no_redis
        noticias_json = obter_noticias_da_pagina(pagina)
      end

      noticias_hash = JSON.parse(noticias_json)
      noticias_array = Array.new

      noticias_hash.each do |noticia|
        noticias_array << Noticia.new(noticia)
      end

      noticias_array
    end
  end

  def self.obter_noticias_da_pagina(pagina)
    $redis.get("noticias_pagina_#{pagina}")
  end

  def self.pesquisar_no_elasticsearch(query, from)

    if (from.blank?)
      from = 0.to_s
    else
      from = (from * LIMITE_NOTICIAS_POR_PAGINA).to_s
    end

    url_completa = ENDERECO_NOTICIAS_ELASTICSEARCH + "_search?q=#{query}&size=" + LIMITE_NOTICIAS_POR_PAGINA.to_s + "&from=#{from}"

    response = HTTParty.get(url_completa, {
        :body => '{"sort": [{ "id": { "order": "desc" } } ] }'
    })

    noticias = Array.new

    JSON.parse(response.body)['hits']['hits'].each do |hit|
      noticias << Noticia.new(hit['_source'])
    end

    noticias
  end

end
