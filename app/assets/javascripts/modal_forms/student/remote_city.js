$(document).ready(function(){
  $('#add-city-button').click(
    
    function(event){
        event.preventDefault(); //This will prevent the buttons default submit behavior
        //...//The rest is up to you!

        var authTok = $("#add-city-form input[name=authenticity_token]").val();
        var cityName = $("#add-city-name").val();
        var cityStateID = $("#add-city-state").val();

        if ( !cityName || !cityName || !cityStateID){
          alert("Ops! Algum campo não foi preenchido")
        }else{
          $.post("/cidades",
          {
            city : {
              name: cityName,
              state_id: cityStateID,
            },
    
            authenticity_token: authTok
    
          },
          function(data, status){
            console.log("Data: " + data + "\nStatus: " + status);
            alert("Cidade adicionada com sucesso!");
          });
    
          city_select = $('#student_city_id');
          $('#student_state_id').val("");
          city_select.empty();
          $("#myModal").css('display','none');
        }



    }
  );
});