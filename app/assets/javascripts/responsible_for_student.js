$(document).ready(() => {
  student_responsible();
  $("#student_birthdate").change(() => student_responsible());

  $(".checkbox_responsible").change( function() {
    $(".checkbox_responsible").prop("checked", false);
    $(".checkbox_responsible").val(false);
    $(this).prop("checked", true);
    $(this).val(true);
    show_responsible_info();
  });

  $('#other_relative_responsible').change(show_responsible_info());
  show_responsible_info();

  $("#submit_student_form").click(() => {
    if ($("#mother_responsible").prop("checked")){
      $("#student_responsible_name").val($("#student_mother_name").val());
      $("#student_responsible_kinship").val("Mãe");
      $("#student_responsible_cpf").val($("#student_mother_cpf").val());
      $("#student_responsible_emai").val($("#student_mother_email").val());
      $("#student_responsible_phone").val($("#student_mother_phone").val());
    }
    
    if ($("#father_responsible").prop("checked")){
      $("#student_responsible_name").val($("#student_father_name").val());
      $("#student_responsible_kinship").val("Pai");
      $("#student_responsible_cpf").val($("#student_father_cpf").val());
      $("#student_responsible_emai").val($("#student_father_email").val());
      $("#student_responsible_phone").val($("#student_father_phone").val());
    }

    if ($("#student_responsible").prop("checked")){
      $("#student_responsible_name").val($("#student_name").val());
      $("#student_responsible_kinship").val("Aluno");
      $("#student_responsible_cpf").val($("#student_cpf").val());
      $("#student_responsible_emai").val($("#student_email").val());
      $("#student_responsible_phone").val($("#student_phone").val());
    }
  });
});

const student_responsible = () => {
  const year = $("#student_birthdate").val().substring(0, 4) * 1;
  const month = $("#student_birthdate").val().substring(5, 7) * 1;

  const currentYear = $("#currentYear").val() * 1;
  const currentMonth = $("#currentMonth").val() * 1;
  
  if ( ((currentYear - year) > 18) || ((currentYear - year) == 18 && month < currentMonth))
    $('.student_responsible').show();
  else 
    $('.student_responsible').hide();
}

const show_responsible_info = () => {
  if ($("#other_relative_responsible").prop("checked")) 
    $("#info_responsible").show();
  else 
    $("#info_responsible").hide();
}