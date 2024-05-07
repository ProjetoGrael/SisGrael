
function build_of_data(n){
  array =[];
  for(let i =0 ; i < n; i++){
    let selected = document.querySelectorAll('.situation')[i];
    const situation = selected.children[selected.selectedIndex].value;
    
    selected = document.querySelectorAll('.participation')[i];
    const participation = selected.children[selected.selectedIndex].value;

    const id = document.querySelectorAll(".presence_id")[i].value;
    // console.log(situation)
    array.push({
       presence: {
         id: id,
         situation: situation,
         participation: participation,
       }
    });
  }
  return array;
}



$(document).ready(function(){
  $('#save_all_presence').click(function(){
    const info_presence = $(".info_presence");
    const data = {
      presences: build_of_data(info_presence.length)
    }
    console.log(JSON.stringify(data));
    const url = "/save_all_lesson"
    $.ajax({
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      url: url,
      type: 'PATCH',
      data: JSON.stringify(data),
      success: function () {
        alert("Todos dados salvos com sucesso")
      },
      error: function (request) {
        alert("Ocorreu um problema ao salvar os dados")
        
      },
    });
  });
});