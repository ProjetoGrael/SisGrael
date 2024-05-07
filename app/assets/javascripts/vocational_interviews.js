
$(
    () => {
        
        if ( $("#vocational-interview-form").length ) 
        { 
            initialConcernsInEdit();
            addAllNecessaryListeners();
            askAboutTransportation();
            ifOtherOpenDivSelectListener("control-openable-select");
            initialConcerns4controlSelects4Edit();
        };
    }
)

//Função para adicionar os listeners
const addAllNecessaryListeners = () => {

    listener2allOfAclass("yes-checkbox", handleChangeYes);
    listener2allOfAclass("no-checkbox", handleChangeNo);
    
    //Adicionando classe ao objeto seletor de meio de transportes para usar
    //a função de adcionar listener.
    if ($("#vocational_interview[project_access]").length) {
        addClassWithId("vocational_interview[project_access]", "project-access-select"); 
        listener2allOfAclass("project-access-select", askAboutTransportation);
    }
    
}





//Se yes já está marcado(no caso do form no edit) torna campos visíveis assim que a página é renderizada
const initialConcernsInEdit = () => {
    const allYesCheckBoxes = document.getElementsByClassName("yes-checkbox");
    for (let i = 0; i < allYesCheckBoxes.length; i++) {
        let checkBox = allYesCheckBoxes[i];
        let granpaDiv = checkBox.parentNode.parentNode;
        let fakeNoCheckBox = granpaDiv.getElementsByClassName("no-checkbox")[0];
        let openableBox = granpaDiv.getElementsByClassName("openable")[0];

        if (checkBox.checked == true) {

            if (openableBox != undefined) {
                openableBox.style.display = "block"
            }

            if (fakeNoCheckBox != undefined){
                fakeNoCheckBox.disabled = true;
            }

        }else{
            if (document.getElementById("flag-edit") && fakeNoCheckBox != undefined) {
                fakeNoCheckBox.checked = true;
                checkBox.disabled = true;
            }
        }

    }

}

//função para adicionar classe a elemento recebendo o name do elemento
const addClassWithId = (name, className) => {
    const element = document.getElementsByName(name)[0];
    element.className += ` ${className}` ;
}

//Para a parte de especificar transportes
const openTextAreaAndChangeLabel = (element, transportType) => {
    const grandFatherDiv = element.parentNode.parentNode;
    const openableField = grandFatherDiv.getElementsByClassName("openable")[0];
    const label = openableField.querySelector("label");
    label.innerHTML = `Qual tipo de ${transportType} você utiliza?`
    openableField.style.display = "block";
}

//Função para abrir caixa que pregunta especificamente do transporte escolhido pelo aluno
const askAboutTransportation = (event) => {
    const select = event ? event.target : document.querySelector("select[name='vocational_interview[project_access]']");
    const selectedOption = select.options[select.selectedIndex];
    // openTextAreaAndChangeLabel(select, selectedOption.value);

}


// <textarea id="vocational_interview_project_access_text" name="vocational_interview[project_access_text]"></textarea>

const listener2allOfAclass = (className, handleFunction) => {
    const allYesCheckBoxes = document.getElementsByClassName(className);
    let element;
    for (let i = 0; i < allYesCheckBoxes.length; i++){
        element = allYesCheckBoxes[i];
        element.addEventListener("change", (event) => handleFunction(event));
    }
}

const handleChangeYes = (event) => {
    const checkBox = event.target;
    const parentDiv = checkBox.parentNode.parentNode.parentNode;
    const fakeNoCheckBox = parentDiv.getElementsByClassName("no-checkbox")[0];
    const openableBox = parentDiv.getElementsByClassName("openable")[0];

    if (checkBox.checked){

        if (openableBox){
            openableBox.style.display = "block";
        }
        
        if (typeof fakeNoCheckBox != "undefined") { fakeNoCheckBox.disabled = true };
    }else{

        if(openableBox){
            openableBox.style.display = "";
        }
        if (typeof fakeNoCheckBox != "undefined") { fakeNoCheckBox.disabled = false };;
    }
}

const cleanTextFields = (fields) => {
    for(i=0; i < fields.length; i++){
        let field = fields[i]
        field.value = ""
    }
}

const handleChangeNo = (event) => {
    const checkBox = event.target;
    const parentDiv = checkBox.parentNode.parentNode;
    const haveOpenable = parentDiv.getElementsByClassName("openable").length > 0;
    
    const YesCheckBox = parentDiv.getElementsByClassName("yes-checkbox")[0];
    if (checkBox.checked){
        YesCheckBox.disabled = true;
        if (haveOpenable) {
            const textAreas = parentDiv.getElementsByClassName("openable")[0].getElementsByTagName("textarea")
            const inputs = parentDiv.getElementsByClassName("openable")[0].getElementsByTagName("input")
            const selects = parentDiv.getElementsByClassName("openable")[0].getElementsByTagName("select")

            cleanTextFields(textAreas)
            cleanTextFields(selects)
            cleanTextFields(inputs)
        }
        
    }else{
        YesCheckBox.disabled = false;
    }
}
