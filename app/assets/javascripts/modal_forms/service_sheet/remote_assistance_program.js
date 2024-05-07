$(document).ready(() => {
  if ($("#service-sheet-form").length) {
    //Esconde formulários
    hideDiv();
    //Get inicial para obter programass já existentes dos aluno
    updateStudentPrograms();
    //Event listener de botão para adicionar membro familiar
    $("#add-program-button").click((event) => {
      event.preventDefault();
      addStudentProgram();
    });

    $("#add-new-program-button").click((event) => {
      event.preventDefault();
      addProgram();
    });

    $("#delete-program-button").click((event) => {
      event.preventDefault();
      callDeleteProgram()
    });

    $("#call-add-new-program-screen").click((event) => {
      event.preventDefault();
      handleClickForAddNew(event)
    });

    $("#call-delete-program-screen").click((event) => {
      event.preventDefault();
      handleClickForDelete(event)
    });

    $(".cancel-program-button").click((event) => {
      event.preventDefault();
      handleClickForAddNewCancel(event)
    });
  }

  if ($("#show-page-flag").length) updateStudentPrograms();
});


const programsSumUp = () => {
  const numberOfSpans = document.getElementById("number-of-programs");
  const totalValueSpan = document.getElementById("total-program");

  numberOfSpans.innerText = `${document.getElementById("assistance-programs").children.length}`;

  let programsValues = document.getElementsByClassName("program-value-span");
  let totalIncome = 0;
  for (let i = 0; i <  programsValues.length; i++) {
    let incomeText = programsValues[i].innerText;
    let income = parseFloat(incomeText.substr(3, incomeText.length - 3))
    totalIncome += income;
  }
  totalValueSpan.innerText = `R$ ${totalIncome.toFixed(2)}`;
  updateRelativesSumUp (totalIncome);
}

const updateRelativesSumUp = (programIncome) => {
  const totalIncomeSpan = document.getElementById("total-income");
  totalIncomeSpan.innerText = `R$ ${(calcTotalIncome() + programIncome).toFixed(2)}`;
}

function callDeleteStudentProgram(id){
  event.preventDefault();
  const programDiv = event.target.parentElement.parentElement;
  let authToken = $("form#add-assistance-program-form input[name=authenticity_token]").val();
  $.ajax({
    url: '/programas_assistenciais_de_alunos/?id=' + id,
    data: { authenticity_token: authToken, id: id },
    type: 'DELETE',
    success: () => { 
      programDiv.remove();
      updateStudentPrograms(); 
    },
    error: () => { updateStudentPrograms(); }
  });
}

function updateStudentPrograms(){
  let studentId = $("input[name='service_sheet[student_id]'").val();
  let url_get = '/assistance_programs/listar-programas?id=' + studentId;
  let programsDiv = $("#assistance-programs");
  getStudentPrograms(url_get, programsDiv);
}  

function addStudentProgram(){
  let authToken = $("#add-assistance-program-form input[name=authenticity_token]").val();
  let studentId = $("#service_sheet_student_id").val();
  let programId = $("#add-assistance-program-select").val();
  let programValue = $("input#add-program-value").val();
  let url_post = '/programas_assistenciais_de_alunos/';
  let url_get = '/assistance_programs/listar-programas?id=' + studentId;
  let programsDiv = $("#assistance-programs");
    
    //Realizando inserção de familiar
  $.post(url_post,
  {
    program_aid : {
      assistance_program_id: programId,
      value: programValue,
      student_id: studentId
    },
    authenticity_token: authToken
  })
  .then(() => {
    document.getElementById('myModal').style.display = "none";
    const form = document.getElementById("add-assistance-program-form");
    const inputs = form.querySelectorAll("input");
    
    for (let cont = 0; cont < inputs.length; cont++) {
      let input = inputs[cont];
      if (input.type != "hidden") input.value = "";
    }
    getStudentPrograms(url_get, programsDiv);
  },
  (error) => {
    document.getElementById("program2student-errors-ul").innerHTML = '';
    errorFeedbackHandling(error.responseJSON, "program2student-errors-ul");
  });
}

const getStudentPrograms = (url, div) => {
  $.get(url, function (programs) {
    // Apagar conteudo da div; div é objeto Jquery
    div.html("");
    Object.keys(programs).forEach((key) => {
      const [name, value, id] = programs[key]
      div.append(
        `<div class="program">
          <div class="button-programs">
            <a href = "#" class="delete-button delete-program" onclick='callDeleteStudentProgram(${id})'>DELETE</a>
          </div>
          <div class="grid-2-columns grid">
            <div class="field-info">
              <p>Nome do programa:</p>
              <span>${name}</span>
            </div>
            <div class="field-info">
              <p>Valor:</p>
              <span class="program-value-span">R$ ${(value * 1.0).toFixed(2)}</span>
            </div>
          </div>
        </div>`
      );
    });
    programsSumUp();
    calculatePerCapta(); 
  });
}

function hideDiv(){
  document.getElementById("add-new-form-div").style.display = "none";
  document.getElementById("delete-form-div").style.display = "none";
}

function handleClickForAddNew(event){
  event.preventDefault();

  document.getElementById("add-new-form-div").style.display = "block";
  document.getElementById("delete-form-div").style.display = "none";
  document.getElementById("add-to-student-form-div").style.display = "none";
}

function handleClickForAddNewCancel(event){
  event.preventDefault();

  document.getElementById("add-new-form-div").style.display = "none";
  document.getElementById("delete-form-div").style.display = "none";
  document.getElementById("add-to-student-form-div").style.display = "block";
}

function handleClickForDelete(event){
  event.preventDefault();

  document.getElementById("add-to-student-form-div").style.display = "none";
  document.getElementById("add-new-form-div").style.display = "none";
  document.getElementById("delete-form-div").style.display = "block";
}

function addProgram(){
  let authToken = $("#add-assistance-program-form input[name=authenticity_token]").val();
  let name = document.getElementById("add-new-program-name").value
  let url_post = `/programas_assistenciais/`
    
  $.post(url_post,
  {
    assistance_program : { name: name},
    authenticity_token: authToken
  })  
  .then((data, status) => {
    const form = document.getElementById("add-new-assistance-program-form");
    const inputs = form.querySelectorAll("input");
    for (let cont = 0; cont < inputs.length; cont++) {
      let input = inputs[cont];
      if (input.type != "hidden") input.value = "";
    }
    updateProgramsSelect();
    
    document.getElementById("add-new-form-div").style.display = "none";
    document.getElementById("delete-form-div").style.display = "none";
    document.getElementById("add-to-student-form-div").style.display = "block";
  },
  (error) => {
    document.getElementById("program-errors-ul").innerHTML = '';
    errorFeedbackHandling(error.responseJSON, "program-errors-ul");
  });
}

function updateProgramsSelect(){
  let url_get = '/assistance_programs/listar-todos-programas';
  let programsSelect = $(".program-select");

  $.get(url_get, function(data){
    programsSelect.empty();
    for (var i = 0; i < data.length; i++){
      programsSelect.append(
        `<option value="${data[i][1]}">${data[i][0]}</option>`
      );
    }    
  });
}  

function callDeleteProgram(){
  event.preventDefault();
  let programId = $("#delete-form-select").val();
  let authToken = $("form#add-assistance-program-form input[name=authenticity_token]").val()
  $.ajax({
    url: '/programas_assistenciais/?id=' + programId,
    data: {authenticity_token: authToken, id: programId},
    type: 'DELETE',
    success: () => {
      updateProgramsSelect();
      updateStudentPrograms();
    }
  });
}
