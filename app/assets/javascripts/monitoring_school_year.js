$(document).ready(function(){
    let school_year_id = document.getElementById('school_year_id').value;
    document.getElementById('pdf_of_concel_link_in_main_page_monitoring').href = `periodos-letivos/${school_year_id}/conselho_pdf.pdf`
    document.getElementById('school_year_info_link_in_main_page_monitoring').href = `periodos-letivos/${school_year_id}/relatorio-de-resultado-do-conselho.pdf`
    document.getElementById("school_year_next_subject_id").href = `/periodos-letivos/${school_year_id}/proxima_turma.xlsx`;

    document.getElementById('school_year_id').addEventListener('change', function() {
        school_year_id = document.getElementById('school_year_id').value;

        document.getElementById('pdf_of_concel_link_in_main_page_monitoring').href = `periodos-letivos/${school_year_id}/conselho_pdf.pdf`
        document.getElementById('school_year_info_link_in_main_page_monitoring').href = `periodos-letivos/${school_year_id}/relatorio-de-resultado-do-conselho.pdf`
        document.getElementById("school_year_next_subject_id").href = `/periodos-letivos/${school_year_id}/proxima_turma.xlsx`;

    });

    let array_buttons = [];
    array_buttons.push(document.getElementById('pdf_of_concel_link_in_main_page_monitoring'));
    array_buttons.push(document.getElementById('school_year_info_link_in_main_page_monitoring'));
    array_buttons.push(document.getElementById("school_year_next_subject_id"));

    for(let i = 0; i < array_buttons.length; i++) {
        array_buttons[i].addEventListener("click", function() {
            alert("Tenha certeza que você selecionou um período letivo!!");
        });
    }

})
