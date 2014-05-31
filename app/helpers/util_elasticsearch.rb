class UtilElasticsearch

  ENDERECO_NOTICIAS_ELASTICSEARCH = "http://localhost:9200/noticias/"

  def self.indexar(id, titulo, corpo, url, categoria)

    response = HTTParty.post(ENDERECO_NOTICIAS_ELASTICSEARCH + "noticia/#{id}", {
        :body => {"titulo" => titulo,
                  "corpo" => corpo,
                  "url" => url,
                  "categoria" => categoria,
                  "id" => id
        }.to_json
    }
    )

    response
  end

  def self.pesquisar(query, from)

    from = definir_limite(from)

    url_completa = ENDERECO_NOTICIAS_ELASTICSEARCH + "_search?q=#{query}&size=" + Noticia::LIMITE_NOTICIAS_POR_PAGINA.to_s + "&from=#{from}"
    url_completa.gsub!(" ", "%20")
    url_completa = UtilString.remover_todos_acentos(url_completa)
    response = HTTParty.get(url_completa)
    response
  end

  def self.pesquisar_por_categoria(categoria, from)

    from = definir_limite(from)

    url_completa = ENDERECO_NOTICIAS_ELASTICSEARCH + "_search?size=" + Noticia::LIMITE_NOTICIAS_POR_PAGINA.to_s + "&from=#{from}"
    url_completa.gsub!(" ", "%20")
    url_completa = UtilString.remover_todos_acentos(url_completa)

    response = HTTParty.get(url_completa, {
        :body => '{"query": {"query_string": {"query": "' + categoria + '","fields": ["categoria2"]}}}'
    })

    response
  end


  def self.definir_limite(from)
    if (from.blank?)
      from = 0.to_s
    else
      from = ((from.to_i - 1) * Noticia::LIMITE_NOTICIAS_POR_PAGINA).to_s
    end
    from
  end

end
