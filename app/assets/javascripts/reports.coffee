# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


#/************************
# * RELATÓRIO FINANCEIRO *
# ************************/

$ ->
  report_kind = $('#financial_report_kind')
  report_kind.on('change', (event) ->
    element = $('#financial_report_element')
    kind = report_kind.val()

    if kind == 'account'
      list_address = "/contas/listar-contas"
    else if kind == 'organization'
      list_address = "/classes/listar-classes"
    else if kind == 'enterprise'
      list_address = "/empresas/listar-empresas"
    else if kind == 'transaction_category'
      list_address = '/naturezas-transacao/listar-naturezas'
    else
      element.empty()
      element.append('<option>Escolha o Tipo de Relatório</option')
      return

    $.ajax(url: list_address).done (result) ->
      element.empty()
      for i in result
        element.append('<option value="'+i[1]+'">'+i[0]+'</option>')
      
  )