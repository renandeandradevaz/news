
<a href="https://codeclimate.com/github/renandeandradevaz/news"><img src="https://codeclimate.com/github/renandeandradevaz/news.png" /></a>


Site de notícias que pega as notícias do g1.globo.com



Veja em produção no link: http://news.renanvaz.info:3000



Desenvolvido em Rails + mysql + elasticsearch + redis



Elasticsearch sendo responsável por todas as pesquisas


Redis sendo responsável por guardar o cache das notícias mais acessadas.


Design responsivo e minimalista para funcionar bem em dispositivos móveis com internet lenta.


Testes com Nightwatch.js



Como instalar:

Instalar mysql, redis e elasticsearch.

Rodar os comandos dentro da pasta do app:

```sh
whenever -i --set environment=production
```

```sh
bundle install
```

```sh
RAILS_ENV=production rake db:create
```

```sh
RAILS_ENV=production rake db:migrate
```

```sh
RAILS_ENV=production bundle exec rake assets:precompile
```

```sh
puma -e production -p 3000
```

Se der algum erro como: "No such file or directory - /temp/profile/". Crie uma pasta com essa estrutura na "/" e dê permissões de leitura e escrita.














