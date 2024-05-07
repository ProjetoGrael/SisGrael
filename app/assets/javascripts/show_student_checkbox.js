function update_checkbox(){
  const token = document.getElementById("authenticity_token").value;
  const checkboxs = document.querySelectorAll(".student_show_checkbox");
  const student_id = document.querySelector("#student_id").value;
  const data = {
    student: {
      rg_missing: checkboxs[0].checked,
      cpf_missing: checkboxs[1].checked,
      responsible_rg_missing: checkboxs[2].checked,
      responsible_cpf_missing: checkboxs[3].checked,
      address_proof_missing: checkboxs[4].checked,
      term_signed_missing: checkboxs[5].checked,
      school_declaration_missing: checkboxs[6].checked,
      medical_certificate_missing: checkboxs[7].checked,
      birth_certificate_missing: checkboxs[8].checked,
      historic_missing: checkboxs[9].checked,

    },
    authenticity_token: token
  };
  const url = "/alunos/" + student_id
  
  $.ajax({
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    url: url,
    type: 'PATCH',
    data: JSON.stringify(data),
    success: function (response) {
      console.log(response)
    },
    error: function (request) {
      console.log(request.responseText)
    
    },
  
  })
  
  

}


$(document).ready(function(){
  $(".student_show_checkbox").change(function(){
    alert('foi');
    update_checkbox();
  });

  $('.chk').click(function(){
    if($(this).attr('checked') == undefined)
    {
        $(this).attr('checked',"");
        $(this).removeAttr('unchecked');
        $(this).siblings().prop('checked', true);
        update_checkbox();
    }
    else
    {
        $(this).removeAttr('checked');
        $(this).attr('unchecked',"");
        $(this).siblings().prop('checked', false);
        update_checkbox();
    }
});
  
});

