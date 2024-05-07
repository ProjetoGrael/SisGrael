$ ->
  state_select = $('#add-neighborhood-state')
  city_select = $('#add-neighborhood-city')
  state_select.on('change', (event) ->
    state_id = state_select.val()
    
    if state_id != ""
      $.ajax(
        url: '/cidades/listar-cidades',
        data: { state_id: state_id }
      ).done (result) ->
        city_select.empty()
        city_select.append('<option></option>')
        for i in result
          city_select.append('<option value="'+i[1]+'">'+i[0]+'</option>')
    else
      city_select.empty()
      city_select.append('<option>Escolha um Estado</option>')
  )

 