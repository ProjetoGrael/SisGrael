$(() => {
  //adicionando listeners para os checkboxes que abrem divs
  if ( $("#service-sheet-form").length ) { 
    initialConcernsInEdit();
    addAllNecessaryListeners();
    ifOtherOpenDivSelectListener("control-openable-select");
    initialConcerns4controlSelects4Edit();
    document.getElementById("salary").onchange = calculatePerCapta();
  }
});

const initialConcerns4controlSelects4Edit = () => {
  const allControlSelects = document.getElementsByClassName("control-openable-select");
  for (let i = 0; i < allControlSelects.length; i++) {
    let select = allControlSelects[i];

    const selectedOption = select.options[select.selectedIndex];
    const comparableText = selectedOption.text.substr(0, 5).toLowerCase();
    const condition = comparableText == "outro" || comparableText == "outra";

    openAndCloseDivWithElement(select, condition);
  }
}

//Para a parte de especificar transportes
const openAndCloseDivWithElement = (element, condition) => {
  const grandFatherDiv = element.parentNode.parentNode;
  const openableField = grandFatherDiv.getElementsByClassName("openable")[0];

  const textAreas = grandFatherDiv.getElementsByClassName("openable")[0].getElementsByTagName("textarea")
  const inputs = grandFatherDiv.getElementsByClassName("openable")[0].getElementsByTagName("input")
  const selects = grandFatherDiv.getElementsByClassName("openable")[0].getElementsByTagName("select")

  if (condition) openableField.style.display = "block";
  else {
    openableField.style.display = "";
    cleanTextFields(textAreas)
    cleanTextFields(selects)
    cleanTextFields(inputs)
  }
}

const ifOtherOpenDivSelectListener = (classNameOfSelect) => {
  $(`.${classNameOfSelect}`).change((event) => {      
    const select = event.target;
    const selectedOption = select.options[select.selectedIndex];
    const comparableText = selectedOption.text.substr(0, 5).toLowerCase();
    const condition = comparableText == "outro" || comparableText == "outra";
    
    openAndCloseDivWithElement(select, condition);
  });
}