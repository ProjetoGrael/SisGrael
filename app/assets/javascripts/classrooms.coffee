# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
    monthSelect = $('#month_select')
    monthSelect.on('change', (event) ->
        month = monthSelect.val()
        href = $('#generate-frequency-list-button').attr('href')
        classroom_id = $('#generate-frequency-list-button').attr('classroom_id')
        $('#generate-frequency-list-button').attr({'href': '/turmas/'+classroom_id+'/'+month+'/pauta_pdf.pdf'})
    )