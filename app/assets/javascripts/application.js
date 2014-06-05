//= require jquery
//= require jquery_ujs

$(document).ready(function(){

    $('#menu').on('click', function(e){
        
        $('#menu').text('&nbsp;');

        if($('#selecione-categoria').find('option').length <= 1){

            $.ajax({
                url: "/noticias/listar_categorias",
                success: function( data ) {
                    $(data).each(function( index, value ) {
                        $('#selecione-categoria').append("<option>" + value +  "</option>");
                    });

                    $('#selecione-categoria').show();
                }
            });
        }
    });

    $('#selecione-categoria').on('change', function(){

        var categoria = $(this).find("option:selected").val();
        $('.categoria').val(categoria);
        $('#selecione-categoria').submit();
    });
});

