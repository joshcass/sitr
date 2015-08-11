$( document ).ready(function(){
    $('#feed-button').on('click', function(){
        $feederId = $(this).data('id');
        $.ajax({
            type: 'GET',
            url: '/pet_feeder/' + $feederId + '/feed',
            success: function(data){
                $('#last-feeding').text(data);
                Materialize.toast('Feeding Successful!', 4000, 'light-green darken-3');
            },
            error: function(response){
                Materialize.toast(response.status + " " + response.statusText, 4000, 'red darken-3');
            }
        });
    });
});
