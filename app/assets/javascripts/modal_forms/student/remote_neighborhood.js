$(document).ready(function(){
$('#add-neighborhood-button').click(
  
    function(event){
        event.preventDefault(); //This will prevent the buttons default submit behavior
        //...//The rest is up to you!
  
        var authTok = $("#add-neighborhood-form input[name=authenticity_token]").val();
        var neighborhoodName = $("#add-neighborhood-name").val();
        var neighborhoodStateID = $("#add-neighborhood-state").val();
        var neighborhoodCityID = $("#add-neighborhood-city").val();

        if ( !neighborhoodName || !neighborhoodStateID || !neighborhoodCityID){
          alert("Ops! Algum campo não foi preenchido");
        }else{
          $.post("/bairros",
          {
            neighborhood : {
              name: neighborhoodName,
              city_id: neighborhoodCityID,
              state_id: neighborhoodStateID
            },
    
            authenticity_token: authTok
    
          },
          function(data, status){
            console.log("Data: " + data + "\nStatus: " + status);
            alert("Bairro adicionado com sucesso!");
          });

          city_select = $('#student_city_id');
          $('#student_state_id').val("");
          city_select.empty();
          $("#myModal").css('display','none');
        }
    }
  );
});