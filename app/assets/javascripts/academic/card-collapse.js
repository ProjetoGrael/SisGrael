$( document ).ready(function() {

    if ($("#final-evaluation")) {
    
        $('.row-name-inscription').on('click', function () {
            $(this).closest('.card-inscription').find('.collapse-field').toggleClass('student-visible'); 
            $(this).find('.inscription-name').toggleClass('inscription-name-underline'); 
        });

    }

});