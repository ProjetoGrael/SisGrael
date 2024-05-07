class Interview < ApplicationRecord
  belongs_to :student, optional: true
  belongs_to :user
  validate :check_time_in_free_time, :check_scheduled_interviews
  
  validates :reason, :date_of_interview, :time_of_interview, :user_id, :student_name, presence: true

  enum kind: {
    interview: 0,
    attendance: 1
  }

  def check_time_in_free_time
    unless time_of_interview.nil? || date_of_interview.nil? || user.nil?
      free_time = user.free_times.where("day = :day and start_at <= :time and finish_at >= :time", {day: date_of_interview, time: time_of_interview})
      errors.add(:time_of_interview, "indisponivel: Horário está fora dos horários do serviço social") if free_time.empty?
    end
  end

  def check_scheduled_interviews 
    unless time_of_interview.nil? || date_of_interview.nil? || user.nil?
      scheduled_interview = user.interviews.where("date_of_interview = :day and time_of_interview = :time", {day: date_of_interview, time: time_of_interview})
      errors.add(:time_of_interview, "indisponivel: Existe uma entrevista marcada no horário escolhido") unless scheduled_interview.empty?
    end
  end
end
