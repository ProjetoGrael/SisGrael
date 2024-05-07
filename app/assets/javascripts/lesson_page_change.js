
//     console.log("lesson_page_change código");
//     console.log($("#select_period"));
//     $("#select_period").change(function (){
//         let current_url = window.location.href
//         let base_url = current_url.substring(0, current_url.indexOf("aulas/") + 6)
//         location.replace(base_url + $("#select_period").val())
//     })
    

$(document).ready(function() {
  $("#select_period").change(function() {
    let current_url = window.location.href;
    let base_url = current_url.substring(0, current_url.indexOf("aulas/") + 6);
    location.replace(base_url + $("#select_period").val())
  })
})
