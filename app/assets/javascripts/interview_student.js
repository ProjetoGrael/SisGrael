$(document).ready( function (){
  $("#student-id-interview select").change(function() {
    const student_id = this.value
    if (!student_id) $("#card-student-interview").html("")
    else {
      $.get(`/usuarios/${student_id}`, 
        {
          method: 'get',
          headers: 
            {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            }
        }
      )
      .then((response)=> {
        const div = $("#card-student-interview")
        div.html(
          `<div class="card">`+
            `${response.name}`+
            `${response.cpf}`+
            `${response.birthdate}`+
            ``+
            ``+
            ``+
          `</div>`
        );
      });
    }        
  }); 
});