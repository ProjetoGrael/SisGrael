
# $(document).ready ->
#   classroomSelect = $('#inscription_classroom_select')
#   submitButton = '<input type="submit" name="commit" value="Realizar Inscrição" data-disable-with="Realizar Inscrição" class = "generate-button">'
#   classroomSelect.change ->
#     id = $(this).val()
#     divForm.empty()
#     divForm.append("<input type='hidden' value='#{id}' name='inscription[classroom_id]'>")
#     $.ajax(url: "/turmas/#{id}/listar-cursos").done (res) ->
#       console.log(res)

#       for course in res
#         courseName = "<p>#{course[0]}</p>"

#         options = ""
#         for level in course[1]
#           options += "<option value='#{level[1]}'>#{level[0]}</option>"

#         attrName = "name='classroom_subjects[#{course[2]}][subject_level_id]'"
#         select = "<select #{attrName}>#{options}</select>"
#         divForm.append(courseName + select)
#       divForm.append(submitButton)
