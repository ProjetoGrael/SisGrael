$(document).ready(function(){
  $(".checkbox_of_secretary").click(function(){
    const value = $(this).prop("checked");
    const id = $(this).parent().children(".student_classroom_subject_id").val();
    const token = document.getElementById("authenticity_token").value;

    const data = {
      student_classroom_subject: {
        show: value
      },
      authenticity_token: token,
    }
    const url = 'student_classroom_subject/' + id;
    
    const checkbox = $(this);
    // alert(url);
    $.ajax({
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      url: url,
      type: 'PATCH',
      data: JSON.stringify(data),
      success: function(){
        console.log("foi um sucesso");
      },
      error: function(){
        alert("Ocorreu um imprevisto");
        checkbox.prop("checked", !value);
      }

    })
  });
});