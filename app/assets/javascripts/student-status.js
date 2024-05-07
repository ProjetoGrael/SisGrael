$(document).ready(()=>{
    $('#student_status').change(()=>{
        if ($('#student_status').val() == "desisted" || $('#student_status').val() == "evaded") {
            $('#status-exclamation').addClass('show');
            alert("Atenção:\n\nVocê alterou o status do aluno para DESISTENTE.")
        } else {
            $('#status-exclamation').removeClass('show');
        }
    });
});