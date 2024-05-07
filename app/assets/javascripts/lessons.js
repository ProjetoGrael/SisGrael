$(document).ready(() => {
    const sentences = document.querySelectorAll('.registration');
    if (sentences) {
        sentences.forEach(function(item) {
            if (item.innerText == "Não preenchida.") {
                item.classList.toggle("alert");
            }
        })
    }
})

