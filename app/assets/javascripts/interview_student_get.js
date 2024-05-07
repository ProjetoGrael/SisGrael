$(document).ready(function() {
  $("#interview_student_id").change(function() {
    if (!$(this).val()) $("#card-student-interview").html('')
    else{
      const student_id = $(this).val()
      const url = `/alunos/${student_id}`

      const data = {authenticity_token: $("#token").val()}
      $.ajax({
        headers: 
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
        url: url,
        type: 'GET',
        data: JSON.stringify(data),
        success: function(response){
          let student_photo = `<img src=${response.photo.small.url} class="student-photo">`
          
          if (response.photo.url === null)
            student_photo = `<div class="student-photo students-icone-panel icon"></div>`
                
          $("#card-student-interview").html(`
            <div class="card">
              <div class= "card-action">
                <div class="action-photo">
                  ${student_photo}
                </div>
              </div>      
              <div class="card-content">
                <div class="titles centered">
                  ${response.name}
              </div>

              <div class="registration interview">
                <a href= "/alunos/${response.id}" class="edit-button">Perfil</a>
              </div>
            </div>
          </div>`
          );
        }
      });
    }
  });
});