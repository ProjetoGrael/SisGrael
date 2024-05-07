function are_you_sure() {
  var name = confirm("Você tem certeza")
  if (name == true) {
    return true
  }
  else {
    return false
  }
}

$(document).ready(function () {

  $(".remove_subject_in_council").click(function () {
    if (!are_you_sure()) return;

    const id = $(this).parent().children(".student_classroom_subject_id").val();
    const token = document.getElementById("authenticity_token").value;

    const data = {
      student_classroom_subject: {
        show: false
      },
      authenticity_token: token,
    }
    const url = 'student_classroom_subject/' + id;

    console.log(JSON.stringify(data));
    const aux = $(this).parent().parent()
    $.ajax({
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      url: url,
      type: 'PATCH',
      data: JSON.stringify(data),
      success: function () {
        aux.hide();
        
      },
      error: function (request) {
        alert("Ocorreu um problema")

      },
    });

  })
})