module Academic::TeachersHelper

  def teacher_link
    if current_user.teacher.present?
      teacher_path(current_user.teacher.id)
    else
      '#'
    end
  end

  def teacher_classroom_subjects_link
    if current_user.teacher.present?
      teacher_classroom_subjects_path(current_user.teacher.id)
    else
      '#'
    end
  end

  def teacher_subjects_link
    if current_user.teacher.present?
      teacher_subjects_path(current_user.teacher.id)
    else
      '#'
    end
  end

  def teacher_user_value(teacher)
    if teacher.user_id.present?
      teacher.user_id
    else
      params[:user_id]
    end
  end

  def sex_options
    [["Masculino", :male], ["Feminino", :female], ["Outro", :other]]
  end

  def pretty_sex(sex)
    hash = {
      male: 'Masculino',
      female: 'Feminino',
      other: 'Outro'
    }
    hash[sex.to_sym]
  end

  def ethnicity_options
    Academic::Teacher.ethnicities.keys
  end

  def percentage_finished_councils
    total_subject_histories = 0
    total_subject_histories_different_nil = 0
    Academic::SchoolYear.active.first.inscriptions.all.each do |inscription| 
        total_subject_histories += inscription.subject_histories.all.length

        inscription.subject_histories.all.each do |sh|
            total_subject_histories_different_nil += 1 if(sh.final_counsel != nil)
        end
    end

    if total_subject_histories != 0
        return ((Float(total_subject_histories_different_nil) / Float(total_subject_histories)) * 100).round().to_s + "%"
    else
        return 0.to_s + "%"
    end
end

def percentage_situation_council(int_situation)
    inscriptions_total = Academic::SchoolYear.active.first.inscriptions.length
    if inscriptions_total != 0
        inscriptions_situation_council = Academic::SchoolYear.active.first.inscriptions.where(situation: int_situation).length
        return (( Float(inscriptions_situation_council) / Float(inscriptions_total)) * 100).round().to_s + "%"
    else
        return 0.to_s + "%"
    end
end

def percentage_grades_council(grade)
    total_grade = 0
    total_different_nil = 0
    council_options = ['A','B','C','D']

    Academic::SchoolYear.active.first.inscriptions.all.each do |inscription| 
        inscription.subject_histories.all.each do |sh|
            if(sh.final_counsel != nil)
                total_grade += 1 if council_options[sh.final_counsel] == grade	
                total_different_nil += 1	
            end
        end
    end
    if(total_different_nil != 0)
        return ((Float(total_grade) / Float(total_different_nil)) * 100).round().to_s + "%"
    else
        return 0.to_s + "%"
    end
end

end
