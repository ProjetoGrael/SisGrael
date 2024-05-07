class UpdateHolidayAttributeOnLessons < ActiveRecord::Migration[5.1]
  def change
    Academic::Lesson.all.each do |lesson|
      isHoliday = false
      #Para todos os feriados do semestre em que se localiza a aula
      Academic::Holiday.where(school_year: lesson.classroom_subject.classroom.school_year).each do |holiday|
        #Se o feriado estiver em um dia de aula
        if lesson.day == holiday.day
          #Seta a flag para true
          isHoliday = true
        end
      end
      #Se a flag for true, significa que tem pelo menos um feriado nesse dia de aula
      if isHoliday == true
        #Então atualiza o atributo para true
        lesson.update_attributes(holiday: true)
      #Caso contrário, atualiza o atributo para false
      else
        lesson.update_attributes(holiday: false)
      end
    end
  end
end
