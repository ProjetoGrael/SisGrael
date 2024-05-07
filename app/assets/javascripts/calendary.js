$(document).ready(function(){
  $("#calendary").on('click',".normal-day", function(){
    const school_year_id = $("#school-year-id").val();
    const token = $("#token").val();
    const date = this.querySelector("input").value;
    const url = "/dias-sem-aula";
    const self = this;
    $.post(url, {
      method: 'post',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: {
        "holiday": {
          "day": date,
          "school_year_id": school_year_id
        },
        "authenticity_token": token 
      }
    })
    .then(() => {
      alert("feriado criado com sucesso");
      $(self).attr('class', 'width-restrit unnormal-day');
    })
    .catch();
  });

  $("#calendary").on('click','.unnormal-day',function(){
    const school_year_id = $("#school-year-id").val();
    const token = $("#token").val();
    const date = this.querySelector("input").value;
    const url = `/dias-sem-aula/${date}`;
    const self = this;
    
    $.ajax(url, {
      type: "DELETE",
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: {
        "holiday": {
          "day": date,
          "school_year_id": school_year_id
        },
        "authenticity_token": token 
      }
    })
    .then(() => {
      alert("feriado destruido com sucesso")
      $(self).attr('class', 'width-restrit normal-day')
    })
    .catch();
  });
});