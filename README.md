==  AINDA EM DESENVOLVIMENTO!!! 
 


Site de notícias que pega as notícias do g1.globo.com


Desenvolvido em Rails + mysql + elasticsearch + redis


Elasticsearch sendo responsável por todas as pesquisas


Redis sendo responsável por guardar o cache das notícias mais acessadas.


Design responsivo e minimalista para funcionar bem em dispositivos móveis com internet lenta.




Como instalar:

Instalar mysql, redis e elasticsearch.

Rodar os comandos dentro da pasta do app:

```sh
whenever -i --set environment=production
```

```sh
RAILS_ENV=production rake db:create
```

```sh
RAILS_ENV=production rake db:migrate
```

```sh
RAILS_ENV=production bundle exec rake assets:precompile

```sh
puma -e production -p 3001
```















