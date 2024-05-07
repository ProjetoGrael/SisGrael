$(document).ready(function() {
  if ($("#service-sheet-form").length) {
    // Get the modal
    var modal = document.getElementById('myModal');
    // Get the button that opens the modal
    var btnFamily = document.getElementById("myBtn-family");
    // Get the button that opens the modal
    var btnExpense = document.getElementById("myBtn-expense");

    // Get the button that opens the modal
    var btnAssistanceProgram = document.getElementById("myBtn-assistance-program");
  
    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];
  
    // When the user clicks on <span> (x), close the modal
    span.onclick = function() { modal.style.display = "none"; }
  
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target == modal) modal.style.display = "none";
    }
  
    // When the user clicks on the button, open the modal 
    btnFamily.onclick = function(event) {
      event.preventDefault();
      $(".section-remote-form").hide();
      $("#family-section-remote-form").show();
      modal.style.display = "block";
    }

    // When the user clicks on the button, open the modal 
    btnExpense.onclick = function(event) {
      event.preventDefault();
      $(".section-remote-form").hide();
      $("#expenses-section-remote-form").show();
      modal.style.display = "block";
    }
    // When the user clicks on the button, open the modal 
    btnAssistanceProgram.onclick = function(event) {
      event.preventDefault();
      $(".section-remote-form").hide();
      $("#assistance-programs-section-remote-form").show();
      $("#add-new-form-div").hide();
      $("#delete-form-div").hide();
      $("#add-to-student-form-div").show();
      modal.style.display = "block";
    }    
  }
});

  
  
  