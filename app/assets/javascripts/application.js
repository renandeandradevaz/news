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

        alert('afdasf');
    });
});


