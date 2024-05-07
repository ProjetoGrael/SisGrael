# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  #As próximas 4 funções servem para fazer com que os o checkbox de permissão de fotos e filmagens não aceitem a resposta sim ou não ao mesmo tempo
  $('#vocational_interview_repetition').ready (e) ->
    a = document.getElementById('vocational_interview_repetition')
    b = document.getElementById('vocational_interview_repetition_no')
    if a.checked 
      b.setAttribute("disabled", "true")
    else if !a.checked 
      b.removeAttribute("disabled")
      if b.checked
        a.setAttribute("disabled", "true")
      else if !b.checked
        a.removeAttribute("disabled")

  $('#vocational_interview_repetition_no').ready (e) ->
    a = document.getElementById('vocational_interview_repetition')
    b = document.getElementById('vocational_interview_repetition_no')
    if b.checked 
      a.setAttribute("disabled", "true")
    else if !b.checked 
      a.removeAttribute("disabled")
      if a.checked
        b.setAttribute("disabled", "true")
      else if !a.checked
        b.removeAttribute("disabled")

  $('#vocational_interview_repetition').click (e) ->
    a = document.getElementById('vocational_interview_repetition')
    b = document.getElementById('vocational_interview_repetition_no')
    if a.checked 
      b.setAttribute("disabled", "true")
    else if !a.checked 
      b.removeAttribute("disabled")
      if b.checked
        a.setAttribute("disabled", "true")
      else if !b.checked
        a.removeAttribute("disabled")

  $('#vocational_interview_repetition_no').click (e) ->
    a = document.getElementById('vocational_interview_repetition')
    b = document.getElementById('vocational_interview_repetition_no')
    if b.checked 
      a.setAttribute("disabled", "true")
    else if !b.checked 
      a.removeAttribute("disabled")
      if a.checked
        b.setAttribute("disabled", "true")
      else if !a.checked
        b.removeAttribute("disabled")
      
  inscriptionModal = $('[event="modal"]')
  modal = document.getElementById('myModal')
  school_year_select = $('#student_school_year')
  classroom_select = $('#student_classroom')
  inscriptionForm = $('#student_inscription_form')

  inscriptionModal.click (e) ->
    e.preventDefault()
    $('.section-remote-form').hide()
    $('#inscription-modal').show()
    modal.style.display = "block";

    id = school_year_select.val()
    $.ajax(
      url: '/turmas/listar-turmas',
      data: { school_year_id: id }
    ).done (response) ->
        classroom_select.empty()
        classroom_select.append('<option></option>')
        for i in response
          classroom_select.append('<option value="'+i[1]+'">'+i[0]+'</option>')

    school_year_select.change ->
      id = school_year_select.val()
      $.ajax(
        url: '/turmas/listar-turmas',
        data: { school_year_id: id }
      ).done (response) ->
        classroom_select.empty()
        classroom_select.append('<option></option>')
        for i in response
          classroom_select.append('<option value="'+i[1]+'">'+i[0]+'</option>')

# students/_form
$ ->
  name = $("input[school_name]").attr('school_name')
  $("input[school_name]").val(name)

$ -> 
  state_select = $('#student_state_id')
  city_select = $('#student_city_id')
  neighborhood_select = $('#student_neighborhood_id')
  state_select.on('change', (event) ->
    state_id = state_select.val()
    
    if state_id != ""
      $.ajax(
        url: '/cidades/listar-cidades',
        data: { state_id: state_id }
      ).done (response) ->
        if response.length > 0
          city_select.empty()
          city_select.append('<option></option>')
          for i in response
            city_select.append('<option value="'+i[1]+'">'+i[0]+'</option>')
        else
          city_select.empty()
          city_select.append('<option>Sem opções</option>')
    else
      city_select.empty()
      city_select.append('<option>Escolha um Estado</option>')
  )

  city_select.on('change', (event) ->
    city_id = city_select.val()

    if city_id != ""
      $.ajax(
        url: '/bairros/listar-bairros',
        data: { city_id: city_id }
      ).done (response) ->
        if response.length > 0
          neighborhood_select.empty()
          for i in response
            neighborhood_select.append('<option value="'+i[1]+'">'+i[0]+'</option>')
        else  
          city_select.empty()
          city_select.append('<option>Sem opções</option>')
    else
      neighborhood_select.empty()
      neighborhood_select.append('<option>Escolha uma Cidade</option>')
  )


$(document).ready ->
  SubjectHistoryButton = $('.card-show .generate-button')

  SubjectHistoryButton.on 'ajax:success', (e) ->
    target = $(e.target)
    target.hide()
    target.after('<h3>Histórico</h3')

    histories = e.detail[0]

    list = SubjectHistoryButton.parent().children('ol')

    for el in histories
      list.append('<li>'+JSON.stringify(el)+'</li>')



pretty_sex=(sex) ->

  if sex == "male"
    return "Masculino"

  if sex == "female" 
    return "Feminino"  

  if sex == "other" 
    return "Outro"


student_age = (birth) ->
  now = new Date()
  year = birth.substring(0, 4)
  month = birth.substring(5, 7)
  day = birth.substring(8, 10)

  if month < now.getMonth()+1 || ( month == now.getMonth()+1 && now.getDate() >= day )
    age = now.getFullYear() - year
  else 
    age = now.getFullYear() - year - 1
 
  return age


months_of_age = (birth) ->
  now = new Date()
  month = birth.substring(5, 7)

  if now.getMonth() + 1 >= month
    age = (now.getMonth() + 1) - month
  else
    age = 12 - month - (now.getMonth()+1)

  return age

responsible = (name) ->
  if name == null
    return ''
  else
    return name


responsible_phone = (phone) ->
  if phone == null
    return ''
  else
    return phone

$(document).ready ->
  #Quando a opção do select for alterada... 
  $('#renewed_students_school_year_select').on('change', (event) ->
    id = $('#renewed_students_school_year_select').val()
    name_school_year = $('#renewed_students_school_year_select').find(":selected").text()

    $.ajax(url: '/alunos/alunos-renovados-json/' + id)
    .done (response) ->

      #Limpa o h1 da pagina e adiciona o título de acordo com o ano letivo selecionado no Select
      $('#h1-renewed-students').empty()
      $('#h1-renewed-students').append($('#renewed_students_school_year_select').find(":selected").text())
      
      #Limpa a div com os links dos usuários que foram renovados nesse periodo e acrescenta os que foram
      #renovados no ano letivo selecionado no select
      $('#div-link-renewed-students').empty()
      $('#div-link-renewed-students').append("
        <p>Há " + response.length + " aluno(s) renovado(s) no período letivo " + name_school_year + ".</p>
      ")
      document.getElementById("generate_xlsx_renewed_students").href = "/alunos/alunos-renovados/" + id + ".xlsx"
      for student in response
        $('#div-link-renewed-students').append("
          <div class='card'>

            <div class='card-action'>
              <a class='card-link' href='/alunos/"+student.id+"'>
                <div class='action-photo'>
                  <div class='student-photo students-icone-panel icon'></div>
                </div>
              </a>
            </div>

            <div class='card-content'>
              <a class='card-link' href='/alunos/" + student.id + "'>

                <div class='titles'>
                    " + student.name + "
                </div>
                <div class='grid discipline'>
                    <div class='field-info'>
                      <p>Matrícula:</p>
                      " + student.registration_number + "
                    </div>

                    <div class='field-info'>
                      <p>Sexo:</p>
                        " + pretty_sex(student.sex) + "
                    </div>

                    <div class='field-info'>
                      <p>Responsável:</p>
                      " + responsible(student.responsible_name) + "
                    </div>

                    <div class='field-info'>
                      <p>Telefone Responsável:</p>
                      " + responsible_phone(student.responsible_phone) + "
                    </div>

                    <div class='field-info'>
                      <p>Idade:</p>
                      " + student_age(student.birthdate) + " ano(s) e " + months_of_age(student.birthdate) + " mes(es)
                    </div>

                </div>
              </a>
            </div>
          </div>
        ")
  )
