//= require jquery
//= require jquery_ujs

$(document).ready(function(){

    $('#menu').on('click', function(e){
        
        $('#menu').text('');
        $('#selecione-categoria').show();

        if($('#selecione-categoria').find('option').length <= 1){

            $.ajax({
                url: "/noticias/listar_categorias",
                success: function( data ) {
                    $(data).each(function( index, value ) {
                        $('#selecione-categoria').append("<option>" + value +  "</option>");
                    });
                }
            });
        }
    });

    $('#selecione-categoria').on('change', function(){

        var categoria = $(this).find("option:selected").val();
        $('.categoria').val(categoria);
        $('#selecione-categoria').submit();
    });


    $('#carregar-mais').on('click', function(e){

            $.ajax({
                url: "/noticias",
                data:{
                  pagina: $('.pagina').val()
                },
                success: function( noticia ) {

                    noticia = noticia[0];

                    if ($("#" + noticia.id).length == 0) {
                        $('#noticias').append("<a href='" + noticia.url +"'> <h2 id='"+ noticia.id + "' class='noticia'> " + noticia.titulo + " </h2> </a>");
                    }

                    $('.pagina').val(parseInt($('.pagina').get(0).value) + 1);
                }
            });
    });
});


