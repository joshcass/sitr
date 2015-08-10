$( document ).ready(function(){
    $('#feed-button').on('click', function(){
        $feederId = $(this).data('id');
        $.ajax({
            type: 'GET',
            url: '/pet_feeder/' + $feederId + '/feed',
            success: function(data){
                $('#last-feeding').text(data);
            }
        });
    });
});
