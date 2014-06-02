require "base64"

class UtilElasticsearch

  ENDERECO_NOTICIAS_ELASTICSEARCH = "http://localhost:9200/noticias/"

  def self.indexar(id, titulo, corpo, url, categoria)

    response = HTTParty.post(ENDERECO_NOTICIAS_ELASTICSEARCH + "noticia/#{id}", {
        :body => {"titulo" => titulo,
                  "corpo" => corpo,
                  "url" => url,
                  "categoria" => UtilString.manter_somente_letras_e_numeros(Base64.encode64(categoria)),
                  "id" => id
        }.to_json
    }
    )

    response
  end

  def self.pesquisar(query, from, limite, fields)

    from = definir_limite(from, limite)

    url_completa = ENDERECO_NOTICIAS_ELASTICSEARCH + "_search?size=" + limite.to_s + "&from=#{from}"
    url_completa.gsub!(" ", "%20")
    url_completa = UtilString.remover_todos_acentos(url_completa)

    response = HTTParty.get(url_completa, {
        :body => '{"query": {"query_string": {"query": "' + query + '","fields": ' + fields.to_s + '}}}'
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
