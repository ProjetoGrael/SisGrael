$(document).ready(function(){
  $('#add-school-button').click(function(event){
    event.preventDefault(); //This will prevent the buttons default submit behavior
    var authTok = $("#add-neighborhood-form input[name=authenticity_token]").val();
    var schoolName = $("#add-school-name").val();
    var school_select = $('#school-field select');
    if (!schoolName) alert("Ops! Algum campo não foi preenchido");
    else {
      $.post("/escolas",
      {
        school : {
          name: schoolName
        },
        authenticity_token: authTok
      },
      function(data, status){
        alert("Escola adicionada com sucesso!");
        $.get( "/escolas/listar-escolas/", function( result ) {
          school_select.empty();
          school_select.append('<option></option>');
          for (let i = 0; i < result.length; i++){
            school_select.append('<option value="'+result[i][1]+'">'+result[i][0]+'</option>');
          }
        });       
      });
      $("#myModal").css('display','none');  
    }
  }
);
});