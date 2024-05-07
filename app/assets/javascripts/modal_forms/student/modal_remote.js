$(
  () => {
    if ( $("#student-form").length ) { openModal() };
  }
  
)

const openModal = () => {
  // Get the modal
  const modal = document.getElementById('myModal');
  // Get the button that opens the modal
  const btnCity = document.getElementById("myBtn-city");
  const btnNeighborhood = document.getElementById("myBtn-neighborhood");
  const btnSchool = document.getElementById("myBtn-school");

  // Get the <span> element that closes the modal
  const span = document.getElementsByClassName("close")[0];

  // When the user clicks on <span> (x), close the modal
  span.onclick = () => {
    modal.style.display = "none"; 
  }

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = (event) => {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }

  // When the user clicks on the button, open the modal 
  btnCity.onclick = () => {
    $(".section-remote-form").hide();
    $("#city-section-remote-form").show();
    modal.style.display = "block";
  }
  btnNeighborhood.onclick = () => {
    $(".section-remote-form").hide();
    $("#neighborhood-section-remote-form").show();
    modal.style.display = "block";
  }
  btnSchool.onclick = () => {
    $(".section-remote-form").hide();
    $("#school-section-remote-form").show();
    modal.style.display = "block";
  }

}


