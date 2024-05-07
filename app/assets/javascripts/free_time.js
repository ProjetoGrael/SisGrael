$(document).ready(() => {

  $("#date_of_interview_select").on("change", function (){
    const schedule_select = document.querySelector("#free_times_schedules");

    let i = schedule_select.children.length - 1
    for(i ; i > 0; i--){ schedule_select.children[i].remove() }
    
    if (this.value){
      const url = "/free_times/get";
      //const token = document.querySelector("#authenticity_token").value;
      //const data = { authenticity_token: token };
      $.ajax({
        headers: 
        {
          Accept: "application/json",
          "Content-Type": "application/json"
        },
        url: url,
        type: "GET",
        error: () => {
          alert("Ocorreu um imprevisto");
          checkbox.prop("checked", !value);
        },
        success: (response) => {
          response.map(free_time => {
            if(free_time.day == this.value){
              const option = document.createElement("option");
              option.text = `${free_time.start_at}-${free_time.finish_at} ${free_time.user_name}`
              option.value = free_time.user_id;
              schedule_select.add(option);
            }
          });
        }
      });
    }
  });
});