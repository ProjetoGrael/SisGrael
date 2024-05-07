$(document).ready(() => {
  if ($("#service-sheet-form").length) {
    //Get inicial para obter despesas já existentes dos aluno
    updateExpense();
    //Event listener de botão para adicionar despesa
    $("#add-expense-button").click((event) => {
      event.preventDefault();
      addExpense(event);
    });
  }
  if ($("#show-page-flag").length) updateExpense();
});

const expensesSumUp = () => {
  if ($("#service-sheet-form").length){
    const totalExpenseSpan = document.getElementById("total-expense");
    const totalExpenses = document.getElementsByClassName("value");
    let totalValue = 0;
    for (let i = 0; i <  totalExpenses.length; i++) {
      let expensesText = totalExpenses[i].innerText;
      let value = parseFloat(expensesText.substr(3, expensesText.length-3))
      totalValue += value;
    }
    totalExpenseSpan.innerText = `R$ ${totalValue.toFixed(2)}`;
  }
}

function callDeleteExpense(id){
  event.preventDefault();
  const authToken = $("form#add-family-member-form input[name=authenticity_token]").val();
  const expenseDiv = event.target.parentElement.parentElement;

  $.ajax({
    url: '/despesas/' + id,
    data: {authenticity_token: authToken, id: id},
    type: 'DELETE',
    success: () => { 
      expenseDiv.remove();
      updateExpense();
    },
    error: () => updateExpense()
  });  
}

function addExpense(event){
  event.preventDefault();
  const authToken = $("#add-family-member-form input[name=authenticity_token]").val();
  const studentId = $("input[name='service_sheet[student_id]'").val();
  const name = $("input#add-expense-name").val();
  const value = $("input#add-expense-value").val();
  const url_post = '/despesas';
  const url_get = '/despesas/listar-despesas?id=' + studentId;
  const expensesList = $("#expenses");
      
  //Realizando inserção de despesa
  $.post(url_post,
  {
    expense : {
      name: name,
      value: value,
      student_id: studentId
    },
    authenticity_token: authToken
  })
  .then(() => {
    document.getElementById('myModal').style.display = "none";
    const form = document.getElementById("add-expense-form");
    const inputs = form.querySelectorAll("input");
    
    for (let cont = 0; cont < inputs.length; cont++) {
      let input = inputs[cont];
      if (input.type != "hidden"){ input.value = "" }
    }
    getStudentExpensens (url_get, expensesList);
  },
  (error) => {
    document.getElementById("expense-errors-ul").innerHTML = '';
    errorFeedbackHandling(error.responseJSON, "expense-errors-ul");
  });
}

function updateExpense(){
  const studentId = $("input[name='service_sheet[student_id]'").val();
  const url_get = '/despesas/listar-despesas?id=' + studentId;
  const expensesList = $("#expenses");

  //Inserção ocorrendo atualiza-se a lista no cliente
  getStudentExpensens (url_get, expensesList);
}  

const getStudentExpensens = (url, div) => {
  $.get(url, function (expenses) {
    div.html("");
    Object.keys(expenses).forEach((key) => {
      const [name, value, id] = expenses[key];
      div.append(
        `<div class="expense">
          <div class="button-students">
            <a href = "#" class="delete-button delete-expense" onclick='callDeleteExpense(${id})'>DELETE</a>
          </div>
          <div class="grid-2-columns grid relatives-list">
            <div class="field-info">
              <p>Nome:</p>
              <span>${name}</span>
            </div>
            <div class="field-info">
              <p>Valor:</p>
              <span class="value">R$ ${(value * 1.0).toFixed(2)}</span>
            </div>
          </div>
        </div>`
      );
    });
    expensesSumUp();
    calculatePerCapta();
  });
}

