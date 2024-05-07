$(document).ready(() => {
  //Get inicial para obter familiares já existentes dos aluno
  setFamily();
  //Event listener de botão para adicionar membro familiar
  $("#add-member-button").click((event) => {
    event.preventDefault();
    addFamily(event);
  });
});

const numberOfFamilyMembers = () =>{
  return document.querySelectorAll('.member').length;
}

const calcAverageIncome = (totalIncome, number) => {
  return (totalIncome ? (totalIncome / number) : totalIncome) ;
}

const calcTotalIncome = () => {
  const membersIncomes = document.querySelectorAll('.renda');
  let totalIncome = 0;

  for (let i = 0; i < membersIncomes.length; i++) {
    let incomeText = membersIncomes[i].innerText;
    let income = parseFloat(incomeText.substr(3, incomeText.length - 3));
    totalIncome += income;
  }
  return totalIncome;
}

const relativesSumUp = () => {
  const averageIncomeSpan = document.getElementById("average-income");
  const totalIncomeSpan = document.getElementById("total-income");
  const numberSpan = document.getElementById("number-of-relatives");
  const totalIncome = calcTotalIncome();
  const membersCount = numberOfFamilyMembers();
  const averageIncome = calcAverageIncome(totalIncome, membersCount);

  averageIncomeSpan.innerText = `R$ ${averageIncome.toFixed(2)}`;
  totalIncomeSpan.innerText = `R$ ${totalIncome.toFixed(2)}`;
  numberSpan.innerText = `${membersCount}`;
}

function callDelete(id) {
  event.preventDefault();
  const parent = event.target.parentElement.parentElement
  const authToken = $("form#add-family-member-form input[name=authenticity_token]").val()
  $.ajax({
    url: '/membros_familiares/' + id,
    data: { authenticity_token: authToken, id: id },
    type: 'DELETE',
    success: () => { 
      parent.remove()
      setFamily(); 
    },
    error: () => setFamily()
  });
}

function setFamily() {
  const studentId = $("input[name='service_sheet[student_id]'").val();
  const url_get = '/membros-familiares/listar-familiares?id=' + studentId;
  const relativesList = $("div#familiares");
  //Inserção ocorrendo atualiza-se a lista no cliente
  getStudentsRelatives (url_get, relativesList);
}

function addFamily(event) {
  event.preventDefault();
  const authToken = $("#add-family-member-form input[name=authenticity_token]").val();
  const studentId = $("input[name='service_sheet[student_id]'").val();
  const name = $("input#add-member-name").val();
  const age = $("input#add-member-age").val();
  const scholarity = $("select[name='scholarity']").val();
  const occupation = $("input#add-member-occupation").val();
  const income = $("input#add-member-income").val();
  const url_post = '/membros_familiares';
  const url_get = '/membros-familiares/listar-familiares?id=' + studentId;
  const relativesList = $("div#familiares");

  //Realizando inserção de familiar
  $.post(url_post,
    {
      family_member: {
        name: name,
        age: age,
        scholarity: scholarity,
        occupation: occupation,
        income: income,
        student_id: studentId
      },
      authenticity_token: authToken
    })
    .then(() => {
      document.getElementById('myModal').style.display = "none";
      const form = document.getElementById("add-family-member-form");
      const inputs = form.querySelectorAll("input");

      for (let cont = 0; cont < inputs.length; cont++) {
        let input = inputs[cont];
        if (input.type != "hidden") input.value = "";
      }
      getStudentsRelatives (url_get, relativesList);
    },
    (error) => {
      document.getElementById("family-errors-ul").innerHTML = '';
      errorFeedbackHandling(error.responseJSON, "family-errors-ul");
    }
  );
}

const getStudentsRelatives = (url, div) => {
  $.get(url, function (relatives) {
    // Apagar conteudo da div; div é objeto Jquery
    div.html("");
    Object.keys(relatives).forEach((key) => {
      const [name, age, scholarity, ocupation, income, id] = relatives[key]
      div.append(
        `<div class="member">
          <div class="button-students">
            <a href = "#" class="delete-button delete-member" style="display: inline-block" onclick='callDelete(${id})'>DELETE</a>
          </div>
          <div class="grid-2-columns grid relatives-list">
            <div class="field-info">
              <p>Nome:</p>
              <span>${name}</span>
            </div>
            <div class="field-info">
              <p>Idade:</p>
              <span>${age}</span>
            </div>
            <div class="field-info">
              <p>Escolaridade:</p>
              <span>${scholarity}</span>
            </div>
            <div class="field-info">
              <p>Ocupação:</p>
              <span>${ocupation}</span>
            </div>
            <div class="field-info">
              <p>Renda:</p>
              <span class="renda">R$ ${(income * 1.0).toFixed(2)}</span>
            </div>
          </div>
        </div>`
      );
    });
    relativesSumUp();
    calculatePerCapta();
  });
}
