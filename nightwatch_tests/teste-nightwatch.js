module.exports = {
  "Teste de pesquisa" : function (client) {
    client
      .url("http://localhost:3000")
      .setValue("#query","Recife 21h38 central da capital")
      .click(".botao-pesquisar")
      .pause(1000)
      .assert.containsText("#noticias", "Árvore cai na Av. João de Barros")
      .end();
  }
};
