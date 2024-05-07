$(document).ready ->
  subjectSelect = $('[name="classroom_subject[subject_id]"]')
  teacherSelect = $('[name="classroom_subject[teacher_id]"]')

  if subjectSelect.length
    subject_id = subjectSelect.val()
    $.ajax(
      url: '/educadores/listar-educadores',
      data: { subject_id: subject_id }
    ).done (result) ->
      teacherSelect.empty()
      teacherSelect.append('<option></option>')
      for i in result
        teacherSelect.append('<option value="'+i[1]+'">'+i[0]+'</option>')

  subjectSelect.change ->
    subject_id = $(this).val()
    $.ajax(
      url: '/educadores/listar-educadores',
      data: { subject_id: subject_id }
    ).done (result) ->
      teacherSelect.empty()
      teacherSelect.append('<option></option>')
      for i in result
        teacherSelect.append('<option value="'+i[1]+'">'+i[0]+'</option>')