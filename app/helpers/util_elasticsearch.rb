require "base64"

class UtilElasticsearch

  ENDERECO_NOTICIAS_ELASTICSEARCH = "http://localhost:9200/noticias/"

  def self.indexar(noticia_hash)

    id = noticia_hash['id']

    response = HTTParty.post(ENDERECO_NOTICIAS_ELASTICSEARCH + "noticia/#{id}", {
        :body => {"titulo" => noticia_hash['titulo'],
                  "corpo" => noticia_hash['corpo'],
                  "url" => noticia_hash['url'],
                  "categoria" => UtilString.manter_somente_letras_e_numeros(Base64.encode64(noticia_hash['categoria'])),
                  "id" => id
        }.to_json
    }
    )

    response
  end

  def self.pesquisar(pesquisa_hash)

    query = pesquisa_hash['query']
    from = pesquisa_hash['from']
    limite = pesquisa_hash['limite']
    fields = pesquisa_hash['fields']
    sort = pesquisa_hash['sort']

    sort = '' if sort.blank?
    from = definir_limite(from, limite)

    url_completa = ENDERECO_NOTICIAS_ELASTICSEARCH + "_search?size=" + limite.to_s + "&from=#{from}"
    url_completa.gsub!(" ", "%20")
    url_completa = UtilString.remover_todos_acentos(url_completa)

    response = HTTParty.get(url_completa, {
        :body => '{"query": {"query_string": {"query": "' + query + '","fields": ' + fields.to_s + '}}' + sort + '}'
    })

    response
  end

  def self.definir_limite(from, limite)
    if (from.blank?)
      from = 0.to_s
    else
      from = ((from.to_i - 1) * limite).to_s
    end
    from
  end

end
