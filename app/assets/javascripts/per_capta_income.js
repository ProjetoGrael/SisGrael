//Para ServiceSheet
const calculatePerCapta = () => {
  if ($("#service-sheet-form").length) {
    const getElementSubstr = (id) => {
      const elementText = document.getElementById(id).innerText;
      if (elementText) return parseFloat(elementText.substr(3, elementText.length-3));
      else return 0;
    }
    const getElement = (id) => {
      const element = document.getElementById(id);
      if (element.innerText) return parseFloat(element.innerText) 
      else return 0;
    }

    const perCaptaSpan = document.getElementById("per-capta-income-span");
    const perCaptaInput = document.getElementById("per-capta-income-input");
    const totalIncomeSpan = document.getElementById("final-total-income-span")  
    const totalIncomeInput = document.getElementById("final-total-income-input")  
    const salary = document.getElementById("salary").value ? parseFloat(document.getElementById("salary").value) : 0
    const programsIncome = getElementSubstr("total-program");
    const expenses = getElementSubstr("total-expense");
    const familyIncome = getElementSubstr("total-income");
    const numberOfPeople = getElement("number-of-relatives");

    const income = (programsIncome - expenses + familyIncome + salary);
    const perCaptaIncome = income / (numberOfPeople + 1);

    totalIncomeSpan.innerHTML = `R$ ${income.toFixed(2)}`;
    totalIncomeInput.value = income.toFixed(2);
    perCaptaSpan.innerHTML = ` R$ ${perCaptaIncome.toFixed(2)}`;
    perCaptaInput.value = perCaptaIncome.toFixed(2);
  }
}








