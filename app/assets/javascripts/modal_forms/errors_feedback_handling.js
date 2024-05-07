const errorFeedbackHandling = (json_response, ulIdName) => {

    const errorUl = document.getElementById(ulIdName);

    for (i=0; i < json_response.length; i++) {
        let error = json_response[i];

        errorUl.innerHTML += `<li>${error}</li>`
    }
}