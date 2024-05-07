module Academic::InscriptionsHelper
  def inscription_student_value(inscription)
    if inscription.student_id
      inscription.student_id
    else
      params[:student_id]
    end
  end
  def situation_options
    [
        ['Estudando',:studying],
        ['Aprovado',:approved],
        ['Participante',:participant],
        ['Reprovado por Falta', :lack_of_lesson]
    ]
  end

  def counsel_options
     ['A','B','C','D']
  end
end
