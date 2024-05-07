# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Script para a seleção do tipo de Custo no form de Financial::Transaction.
jQuery ->
    $("#cost-type-select").change ->
        answer = $("#cost-type-select :selected").text()
        descriptionField = $("#transaction-form-description")
        selectField = $("#form-costs")
        
        # Por padrão, description hidden e selectField exibido.
        descriptionField.parent().addClass("hide")
        descriptionField.val("")
        selectField.parent().removeClass("hide")

        if answer == "Projeto"
            $.ajax({url: "/transactions/form_costs/project"})
            $("#transaction-form-projects").parent().removeClass("hide")
            $("#form-costs").parent().removeClass("hide")

        else if answer == "Custo Fixo"
            $.ajax({url: "/transactions/form_costs/fixed_cost"})
            $("#transaction-form-projects").parent().addClass("hide")

        else
            selectField.empty()
            selectField.parent().addClass("hide")
            descriptionField.parent().removeClass("hide")
            $("#transaction-form-projects").parent().addClass("hide")
            $("#transaction-form-rubrics").parent().addClass("hide")

jQuery ->
    $("#transaction-form-projects").change ->
        project_id = $("#transaction-form-projects").val()
        $.ajax({url: "/transactions/form_rubrics/#{project_id}"})