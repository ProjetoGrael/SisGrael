function changeLink() {
    link = document.getElementById("general-monitoring-link");
    school_year_id_one = document.getElementById('select_school_year_one_general_report').value;
    school_year_id_two = document.getElementById('select_school_year_two_general_report').value;
    school_year_id_three = document.getElementById('select_school_year_three_general_report').value;
    school_year_id_four = document.getElementById('select_school_year_four_general_report').value;
    
    if(school_year_id_one == "") {school_year_id_one = 0}
    if(school_year_id_two == "") {school_year_id_two = 0}
    if(school_year_id_three == "") {school_year_id_three = 0}
    if(school_year_id_four == "") {school_year_id_four = 0}

    bool_general_data = document.getElementById("type_general_data").checked ? 1:0;
    bool_council_monitoring = document.getElementById("type_council_monitoring").checked ? 1:0;
    bool_instructor_monitoring = document.getElementById("type_instructor_monitoring").checked ? 1:0;
    bool_social_service_monitoring = document.getElementById("type_social_service_monitoring").checked ? 1:0;
    bool_student_profile = document.getElementById("type_student_profile").checked ? 1:0;

    link.href = `/monitoramento/relatorio-geral/${school_year_id_one}/${school_year_id_two}/${school_year_id_three}/${school_year_id_four}/${bool_general_data}/${bool_student_profile}/${bool_instructor_monitoring}/${bool_council_monitoring}/${bool_social_service_monitoring}.xlsx`;
}

$(document).ready(function(){
    $('#select_school_year_one_general_report').change(() => {
        changeLink()
    })
    $('#select_school_year_two_general_report').change(() => {
        changeLink()
    })
    $('#select_school_year_three_general_report').change(() => {
        changeLink()
    })
    $('#select_school_year_four_general_report').change(() => {
        changeLink()
    })
    $('#type_general_data').change(() => {
        changeLink()
    })
    $('#type_council_monitoring').change(() => {
        changeLink()
    })
    $('#type_instructor_monitoring').change(() => {
        changeLink()
    })
    $('#type_social_service_monitoring').change(() => {
        changeLink()
    })
    $('#type_student_profile').change(() => {
        changeLink()
    })
    changeLink()
})
