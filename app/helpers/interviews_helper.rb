module InterviewsHelper
  def user_option
    User.where(kind: "social_service").map {|el| [el.name, el.id]} 
  end

  def student_option
    Student.all.map {|el| [el.name, el.id]} 
  end

  def interview_kinds
    [
      ["Entrevista", :interview],
      ["Atendimento", :attendance]
    ]
  end

  def translate_interview_kind(kind)
    hash = {
      interview: "Entrevista",
      attendance: "Atendimento"
    }
    hash[kind.to_sym]
  end

  def more_on_zero minute
    minute = "0" + minute.to_s if minute.to_s.length == 1
    minute
  end

  def free_times_options
    free_times = FreeTime.where('day >= ?', Date.today).order(:day).joins(:user).select(:day, :start_at, :finish_at, :user_id)
    aux_array = []
    free_times.each do |ft| 
      free_time = ft.format_hash
      aux_array.push(
        [
          "#{free_time[:start_at]}-#{free_time[:finish_at]} #{free_time[:user_name]}", 
          ft.user_id
        ])
    end
    free_times = aux_array
  end
  def interview_date_options
    free_times = FreeTime.where('day >= ?', Date.today).order(:day).select(:day).uniq { |ft| ft.day }
    aux_array = []
    free_times.each { |ft| aux_array.push([ "#{I18n.l(ft.day)}", ft.day ]) }
    free_times = aux_array
  end
end
