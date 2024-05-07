$(document).ready(function(){
  $(".class_subject_select #teacher_id").on("change", function () {
    const dicipline_select = document.querySelector(".class_subject_select").children[1]
      
    if (this.value) {
      const url = `/educadores/${this.value}/select_disciplinas`
      
      $.ajax({
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
        url: url,
        type: "GET",
        error: () => {
          alert("Ocorreu um imprevisto");
          checkbox.prop("checked", !value);
        }
      })
      .then(res => {
        dicipline_select.innerHTML = `<option value="">Escolha a Disciplina...</option>`;
        res.subjects.map(sub => {
            const option = document.createElement("option");
            option.text = sub.name;
            option.value = sub.id;
            dicipline_select.add(option);
        });
      });
    }
    else {
      dicipline_select.innerHTML = `<option value="">Escolha a Disciplina...</option>`;
    }
  });
})