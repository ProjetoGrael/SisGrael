$(document).ready ->
    school_select = $('#student_school_id')
    
    if school_select
      $.ajax(
          url: '/escolas/listar-escolas'
        ).done (result) ->
          school_select.empty()
          school_select.append('<option></option>')
          for i in result
            school_select.append('<option value="'+i[1]+'">'+i[0]+'</option>')   
    

 