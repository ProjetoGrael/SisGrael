$ ->
    $("button[responsible='mother']").click (e) ->
        e.preventDefault()
        name = $('#student_mother_name').val()
        cpf = $('#student_mother_cpf').val()
        email = $('#student_mother_email').val()
        phone = $('#student_mother_phone').val()
        $('#student_responsible_name').val(name)
        $('#student_responsible_cpf').val(cpf)
        $('#student_responsible_email').val(email)
        $('#student_responsible_phone').val(phone)

    $("button[responsible='father']").click (e) ->
        e.preventDefault()
        name = $('#student_father_name').val()
        cpf = $('#student_father_cpf').val()
        email = $('#student_father_email').val()
        phone = $('#student_father_phone').val()
        $('#student_responsible_name').val(name)
        $('#student_responsible_cpf').val(cpf)
        $('#student_responsible_email').val(email)
        $('#student_responsible_phone').val(phone)

    $("button[responsible='student']").click (e) ->
        e.preventDefault()
        name = $('#student_name').val()
        cpf = $('#student_cpf').val()
        email = $('#student_email').val()
        phone = $('#student_phone').val()
        if !phone
            phone = $('#student_mobile_phone').val()
        $('#student_responsible_name').val(name)
        $('#student_responsible_cpf').val(cpf)
        $('#student_responsible_email').val(email)
        $('#student_responsible_phone').val(phone)